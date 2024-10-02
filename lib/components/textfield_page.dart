import 'package:flutter/material.dart';

class TextfieldPage extends StatelessWidget {
  final String hintText;
  final IconData? suffixIcon;
  final bool? obscureText;
  final TextEditingController? controller;
  // final bool? showPassword;
  final void Function()? onPressed;

  const TextfieldPage({
    super.key,
    this.suffixIcon,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    // this.showPassword,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: onPressed, icon: Icon(suffixIcon)) // Use Icon if no interaction is needed
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
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
focusColor: Colors.white
        ),
      ),
    );
  }
}
