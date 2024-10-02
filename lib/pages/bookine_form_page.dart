import 'package:car_rental_app/services/stripe_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/booking.dart';
import '../model/car.dart';

class BookingFormPage extends StatefulWidget {
  final Car car;

  const BookingFormPage({Key? key, required this.car}) : super(key: key);

  @override
  _BookingFormPageState createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  bool _isSubmitting = false;

  double get _dailyRate => widget.car.dailyRate;

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  double _calculateTotalPrice() {
    if (_startDate == null || _endDate == null) return 0.0;

    final duration = _endDate!.difference(_startDate!).inDays;
    final days = duration > 0 ? duration : 1; // Ensure at least 1 day

    return days * _dailyRate;
  }

  Future<void> _processPayment(double amount) async {
    setState(() {
      _isSubmitting = true; // Disable button while processing
    });

    final isPaymentSuccessful = await StripeService.instance.makePayment(amount);

    if (isPaymentSuccessful) {
      // Payment was successful, save the booking
      await _saveBooking();
    } else {
      // Payment failed, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment failed. Please try again.')),
      );
    }

    setState(() {
      _isSubmitting = false; // Re-enable button after processing
    });
  }

  Future<void> _saveBooking() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    final bookingId = FirebaseFirestore.instance.collection('bookings').doc().id;
    final totalPrice = _calculateTotalPrice();

    // Get full name and phone number input values
    final fullName = _fullNameController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();

    // Ensure the full name and phone number are provided
    if (fullName.isEmpty || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all the required fields')),
      );
      return;
    }

    final booking = Booking(
      id: bookingId,
      userId: currentUser.uid,
      carId: widget.car.id,
      startDate: _startDate!,
      endDate: _endDate!,
      status: 'Pending',
      totalPrice: totalPrice,
      fullName: fullName,
      phoneNumber: phoneNumber,
    );

    try {
      await FirebaseFirestore.instance.collection('bookings').doc(booking.id).set(booking.toMap());
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking confirmed and payment processed')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _submitBooking() async {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both start and end dates')),
      );
      return;
    }

    final totalPrice = _calculateTotalPrice();

    // Proceed to payment
    await _processPayment(totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('Book Car',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Text(
                    'Book Now',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Icon(Icons.more_horiz_outlined),
                  ),
                ],
              ),
              Center(
                child: Image.network(
                  widget.car.imageUrl,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  widget.car.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary
                      )
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: const OutlineInputBorder(

                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary
                      )
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _startDateController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary
                      )
                  ),
                ),

                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _startDate = selectedDate;
                      _startDateController.text = _startDate!.toLocal().toString().split(' ')[0];
                    });
                  }
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _endDateController,
                decoration: InputDecoration(
                  labelText: 'End Date',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary
                      )
                  ),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _endDate = selectedDate;
                      _endDateController.text = _endDate!.toLocal().toString().split(' ')[0];
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displaySmall?.color,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitBooking,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : Text(
                  'Confirm Booking',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
