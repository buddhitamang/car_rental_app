import 'package:car_rental_app/components/splash_container.dart';
import 'package:car_rental_app/pages/home_page.dart';
import 'package:car_rental_app/pages/main_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List container = ['Search', 'Compare', 'Hire'];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 75.0),
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(
                      'lib/assets/light.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(
                      'lib/assets/splashimg.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: container.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SplashContainer(text: container[index]),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(children: [
                    Text(
                      'Find the ideal car rental for your trip!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 43,
                        color: Colors.white70,
                      ),
                    )
                  ]),
                  SizedBox(height: 18),
                  Wrap(children: [
                    Text(
                      'Get access to the best deals from global car rental companies',
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    )
                  ]),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.green.shade400,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
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
