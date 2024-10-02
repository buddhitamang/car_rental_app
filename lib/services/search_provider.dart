import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/car.dart';

class SearchProvider with ChangeNotifier {
  String _lastSearchedBrand = '';
  List<String> _recommendedCars = []; // Store recommended car IDs or names

  String get lastSearchedBrand => _lastSearchedBrand;
  List<String> get recommendedCars => _recommendedCars;

  SearchProvider() {
    // Load recommended cars on initialization
    loadRecommendedCars();
  }

  // Function to update the last searched brand
  void updateLastSearchedBrand(String brand) {
    _lastSearchedBrand = brand;
    notifyListeners();
  }

  // Save recommended car to SharedPreferences
  Future<void> saveRecommendedCar(String carId) async {
    if (!_recommendedCars.contains(carId)) {
      _recommendedCars.add(carId);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('recommendedCars', _recommendedCars);
      notifyListeners();
    }
  }

  // Load recommended cars from SharedPreferences
  Future<void> loadRecommendedCars() async {
    final prefs = await SharedPreferences.getInstance();
    _recommendedCars = prefs.getStringList('recommendedCars') ?? [];
    notifyListeners();
  }
  // Future<void> loadRecommendedCars() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final List<String>? carsJsonList = prefs.getStringList('recommendedCars');
  //
  //   if (carsJsonList != null) {
  //     _recommendedCars = carsJsonList
  //         .map((carJson) => Car.fromJson(json.decode(carJson))).cast<String>()
  //         .toList();
  //   }
  //
  //   notifyListeners(); // Notify listeners about the change
  // }

  // Clear recommended cars
  Future<void> clearRecommendedCars() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('recommendedCars');
    _recommendedCars.clear();
    notifyListeners();
  }
}
