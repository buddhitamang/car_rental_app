import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrandCar extends StatelessWidget {
  final String imagePath;
  final String carName;
  final String seatCapacity;
  final String rate;
  final String rating;

  const BrandCar({
    super.key,
    required this.imagePath,
    required this.carName,
    required this.seatCapacity,
    required this.rate, required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 200,
        height: 245,
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
                    topRight: Radius.circular(12)),
                child: Image.network(
                  imagePath,
                  height: 140,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures spacing between car name and rating
                children: [
                  Expanded( // Wrap carName in an Expanded widget to control its space
                    child: Text(
                      carName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.displayMedium?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        rating,
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
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bus_alert_sharp),
                      Text(
                        seatCapacity,
                        style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayMedium?.color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.payment),
                      Text(
                        rate,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              Theme.of(context).textTheme.displayMedium?.color,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
