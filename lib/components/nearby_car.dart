import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NearbyCar extends StatelessWidget {
  final String imagePath;
  final String carName;
  final String seatCapacity;
  final String rate;
  final String rating;

  const NearbyCar({
    super.key,
    required this.imagePath,
    required this.carName,
    required this.seatCapacity,
    required this.rate,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 400,
        height: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                imagePath,
                width: 400,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      carName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.displayMedium?.color,
                      ),
                      overflow: TextOverflow.ellipsis, // Adds ellipsis if text is too long
                      maxLines: 1, // Restricts to one line
                    ),
                  ),
                  SizedBox(width: 8), // Adds some space between the car name and rating
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        rating,// Replace this with a dynamic rating if needed
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.displayMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bus_alert_sharp),
                      SizedBox(width: 4),
                      Text(seatCapacity,style: TextStyle( color: Theme.of(context).textTheme.displayLarge?.color),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.payment),
                      SizedBox(width: 4),
                      Text(rate,style: TextStyle( color: Theme.of(context).textTheme.displayLarge?.color),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
