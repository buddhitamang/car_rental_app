import 'package:flutter/material.dart';

class Brands extends StatelessWidget {
  final String imagePath;
  final String brandName;

  const Brands({super.key, required this.imagePath, required this.brandName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the image and text
        children: [
          ClipOval(
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
          SizedBox(height: 8),
          Text(
            brandName,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.displaySmall?.color),
          ),
        ],
      ),
    );
  }
}
