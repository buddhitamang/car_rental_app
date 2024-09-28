import 'package:car_rental_app/pages/auth_page.dart';
import 'package:car_rental_app/services/auth_services.dart';
import 'package:car_rental_app/services/search_provider.dart';
import 'package:car_rental_app/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'model/car_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  final carProvider = CarProvider();
  await carProvider.addBestCarsToFirestore();

  // Create an instance of ThemeProvider and load the theme
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme(); // Load the saved theme

  // final searchProvider = SearchProvider();
  // await searchProvider.loadRecommendedCars();

  // Ensure `brand` is defined or pass a valid argument
  // await carProvider.addBrandsToFirestore();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CarProvider>(
          create: (context) =>
          carProvider, // Use the same instance of CarProvider
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => themeProvider, // Use the preloaded instance here
        ),
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: Provider.of<ThemeProvider>(context).themeData, // Use the loaded theme
    );
  }
}
