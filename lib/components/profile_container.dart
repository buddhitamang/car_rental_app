import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  final String number;
  final String title;
  final Color backgroundColor;
  const ProfileContainer({super.key, required this.number, required this.title, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 130,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(number,style: TextStyle(fontSize: 35,color: Colors.white70,fontWeight: FontWeight.bold),),
            Text(title,style: TextStyle(fontSize: 18,color: Theme.of(context).textTheme.displayLarge?.color),),
          ],
        ),
      ),
    );
  }
}
