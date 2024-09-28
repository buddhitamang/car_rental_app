import 'package:flutter/material.dart';

class ProfileSettingContainer extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subTitle;
  // final IconData iconButton;

  const ProfileSettingContainer({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(leadingIcon),
          title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          subtitle: Text(subTitle),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
        ),
      ),
    );
  }
}
