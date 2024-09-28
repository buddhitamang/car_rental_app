import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String seats;
  final double dailyRate;
  final String enginePower;
  final String maxSpeed;
  final String rating;

  Car({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.seats,
    required this.dailyRate,
    required this.enginePower,
    required this.maxSpeed,
    required this.rating, // Ensure rating is a String
  });

  // fromJson constructor with null safety
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
      imageUrl: json['imageUrl'] ?? '',
      seats: json['seats'] ?? 'N/A',
      dailyRate: (json['dailyRate'] ?? 0.0).toDouble(),
      enginePower: json['enginePower'] ?? 'N/A',
      maxSpeed: json['maxSpeed'] ?? 'N/A',
      rating: (json['rating'] ?? '0.0').toString(), // Ensure rating is a String
    );
  }

  // Factory constructor to create a Car from Firestore document
  factory Car.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data(); // Get the document data as Map<String, dynamic>
    return Car(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      seats: data['seats'] ?? '',
      dailyRate: (data['dailyRate'] ?? 0).toDouble(),
      enginePower: data['enginePower'] ?? '',
      maxSpeed: data['maxSpeed'] ?? '',
      rating: data['rating'] ?? '',
    );
  }

  // toJson method to serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'seats': seats,
      'dailyRate': dailyRate,
      'enginePower': enginePower,
      'maxSpeed': maxSpeed,
      'rating': rating, // Ensure rating is saved as a String
    };
  }
}
