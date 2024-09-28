import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashContainer extends StatelessWidget {
  final String text;
  const SplashContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: LinearGradient(
          colors: [Colors.grey.shade800, Colors.grey.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

      ),
      padding: EdgeInsets.all(8),
      child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
    );
  }
}
