import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_rental_app/components/brand_car.dart';
import 'package:car_rental_app/pages/car_details_page.dart';
import 'package:flutter/material.dart';

import '../model/brand.dart';
import '../model/car.dart';

class BrandCarsPage extends StatelessWidget {
  final Brand brand;

  const BrandCarsPage({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Row(
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
                    '${brand.name} Cars',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                  Container(), // Empty container for alignment
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('brands')
                    .doc(brand.id) // Get the specific brand
                    .collection(
                        'cars') // Assuming cars are stored in a sub-collection
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No cars found.'));
                  }

                  final carsDocs = snapshot.data!.docs;
                  final List<Car> carList = carsDocs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return Car(
                      id: doc.id,
                      name: data['name'],
                      seats: data['seats'],
                      dailyRate: (data['dailyRate'] is int)
                          ? (data['dailyRate'] as int).toDouble()
                          : data['dailyRate'], // Ensure dailyRate is always a double
                      imageUrl: data['imageUrl'],
                      description: data['description'] ?? '',
                      enginePower: data['enginePower'] ?? '',
                      maxSpeed: data['maxSpeed'] ?? '',
                      rating: data['rating']??'0.0',
                    );
                  }).toList();


                  return GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: carList.length,
                    itemBuilder: (context, index) {
                      final Car car = carList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailsPage(car: car),
                            ),
                          );
                        },
                        child: BrandCar(
                          carName: car.name,
                          seatCapacity: car.seats,
                          rate: '\$${car.dailyRate.toStringAsFixed(1)}/day',
                          imagePath: car.imageUrl,
                          rating: car.rating,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
