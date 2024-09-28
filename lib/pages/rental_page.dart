import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this for better date formatting

import '../model/booking.dart';

class BookingListPage extends StatelessWidget {
  Future<void> cancelBooking(String bookingId) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      await _firestore.collection('bookings').doc(bookingId).delete();
      // Optionally show a success message or handle post-cancellation actions
    } catch (e) {
      print('Error canceling booking: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Bookings'),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Text('You need to be logged in to view your bookings.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Your Bookings',style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color),),
        backgroundColor: Colors.transparent,
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('bookings')
                .where('userId', isEqualTo: currentUser.uid)
                .where('status', isEqualTo: 'pending')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return SizedBox.shrink();
              }

              final pendingCount = snapshot.data!.docs.length;

              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    'Pending: $pendingCount',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.displayMedium?.color),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where('userId', isEqualTo: currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No bookings found'));
          }

          final bookings = snapshot.data!.docs
              .map((doc) => Booking.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              final formattedStartDate =
              DateFormat('yMMMd').format(booking.startDate);
              final formattedEndDate =
              DateFormat('yMMMd').format(booking.endDate);

              return ListTile(
                title: Text('Car ID: ${booking.carId}',style: TextStyle( color: Theme.of(context).textTheme.displayLarge?.color),),
                subtitle: Text('From: $formattedStartDate To: $formattedEndDate,',style: TextStyle( color: Theme.of(context).textTheme.displayLarge?.color),),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(booking.status),
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            title: Text('Cancel Booking'),
                            content: Text('Are you sure you want to cancel this booking?',style: TextStyle( color: Theme.of(context).textTheme.displayLarge?.color),),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await cancelBooking(booking.id);
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
