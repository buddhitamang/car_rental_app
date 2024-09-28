import 'package:car_rental_app/pages/login_or_register_page.dart';
import 'package:car_rental_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/helper_function.dart';
import '../components/textfield_page.dart';
import '../services/auth_services.dart';
import 'main_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key,  this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPwController = TextEditingController();

  bool isLoading=false;
  void signUp() async {
    setState(() {
      isLoading=true;
    });
    if (passwordController.text != confirmPwController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      UserCredential userCredential = await authService.signUpWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        print('User registered successfully: ${userCredential.user!.email}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }finally{
      setState(() {
        isLoading=false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Register',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700),
              ),
              Text('Enter your Personal Information',style: TextStyle(fontSize: 18,color: Theme.of(context).textTheme.displaySmall?.color),),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Container(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(18),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface
                ),
                child: Column(
                  children: [
                    TextfieldPage(
                      controller: usernameController,
                      suffixIcon: null,
                      hintText: 'Enter your name',
                    ),
                    TextfieldPage(
                      controller: emailController,
                      suffixIcon: null,
                      hintText: 'Enter your email',
                    ),
                    TextfieldPage(
                      controller: passwordController,
                      suffixIcon: Icons.remove_red_eye,
                      hintText: 'Enter your Password',
                      obscureText: true,
                    ),
                    TextfieldPage(
                      controller: confirmPwController,
                      suffixIcon: Icons.remove_red_eye,
                      hintText: 'Enter confirm password',
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: GestureDetector(
                        onTap: signUp,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.deepPurpleAccent.shade200,
                          ),
                          width: double.infinity,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: isLoading? CircularProgressIndicator():Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 18,color: Theme.of(context).textTheme.displayLarge?.color),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Login',
                            style:
                            TextStyle(fontSize: 18, color: Colors.blue.shade800),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      )),
    );
  }
}
