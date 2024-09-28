import 'package:car_rental_app/pages/bookine_form_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/car.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;

  const CarDetailsPage({Key? key, required this.car,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  child: Image.network(
                    car.imageUrl,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
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
                        'Car Details',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:Theme.of(context).colorScheme.surface,
                        ),
                        child: Icon(Icons.more_horiz_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            car.name,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Theme.of(context).textTheme.displayLarge?.color,),
                              overflow: TextOverflow.ellipsis, // Adds ellipsis if text is too long
                              maxLines: 1, 
                          ),
                          Row(
                            children: [
                              Icon(Icons.star,color: Colors.amber,),
                              Text(car.rating,style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color,fontWeight: FontWeight.bold,fontSize: 18),),
                            ],
                          )
                          
                        ],
                      ),
                      Text(
                        car.description,
                        style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.displayMedium?.color),
                      ),
                      SizedBox(height: 5),
                      Divider(),
                      SizedBox(height: 5),
                      Text(
                        'Specification',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color:  Theme.of(context).textTheme.displayMedium?.color),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildSpecificationCard(
                            icon: Icons.bus_alert_sharp,
                            title: 'Capacity',
                            value: '${car.seats} ',
                          ),
                          buildSpecificationCard(
                            icon: Icons.grid_view_outlined,
                            title: 'Engine Specs',
                            value: '${car.enginePower}', // Ensure you have enginePower in your Car model
                          ),
                          buildSpecificationCard(
                            icon: Icons.speed_sharp,
                            title: 'Max Speed',
                            value: '${car.maxSpeed} ', // Ensure you have maxSpeed in your Car model
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color:  Theme.of(context).colorScheme.surface
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rental price',
                          style: TextStyle(fontSize: 22, color:  Theme.of(context).textTheme.displayLarge?.color,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${car.dailyRate}/day',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color:  Theme.of(context).textTheme.displaySmall?.color),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color:  Theme.of(context).primaryColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue.shade600),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingFormPage(car: car,)));
                        },
                        child: Text(
                          'Book Car',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSpecificationCard({required IconData icon, required String title, required String value}) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.blue.shade900,
              size: 24,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
