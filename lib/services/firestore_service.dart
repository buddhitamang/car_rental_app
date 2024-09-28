import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/brand.dart';
import '../model/car.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Brand>> fetchAllBrandsWithCars() async {
    final brandSnapshots = await _db.collection('brands').get();
    final allBrands = await Future.wait(brandSnapshots.docs.map((doc) async {
      final data = doc.data();
      final carsSnapshot = await doc.reference.collection('cars').get();
      final cars = carsSnapshot.docs.map((carDoc) {
        final carData = carDoc.data();
        return Car.fromJson(carData); // Implement Car.fromFirestore
      }).toList();
      return Brand(
        id: doc.id,
        name: data['name'],
        logoUrl: data['logoUrl'],
        cars: cars,
      );
    }).toList());
    return allBrands;
  }

  Future<List<Car>> fetchBestCars() async {
    final bestCarSnapshots = await _db.collection('bestCars').get(); // Assuming you have a collection for best cars
    return bestCarSnapshots.docs.map((doc) {
      final data = doc.data();
      return Car.fromJson(data); // Make sure to implement Car.fromFirestore
    }).toList();
  }
}
