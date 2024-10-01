import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/textfield_page.dart';

class ForgotPwPage extends StatefulWidget {
  const ForgotPwPage({super.key});

  @override
  State<ForgotPwPage> createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends State<ForgotPwPage> {
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _auth = FirebaseAuth.instance;
    // String? _errorMessage;

    void _resetPassword() async {
      String email = _emailController.text.trim(); // Trim the email input

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please enter your email address.',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        );
        return;
      }

      try {
        await _auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Password reset email sent!',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        );
        Navigator.pop(context); // Optionally navigate back
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message.toString(),
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your email ",
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displayLarge?.color),
            ),
            TextfieldPage(
              controller: _emailController,
              suffixIcon: Icons.person,
              hintText: 'Enter your email',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Theme.of(context).colorScheme.surface),
              child: Text('Send Reset Email'),
            ),
          ],
        ),
      ),
    );
  }
}
