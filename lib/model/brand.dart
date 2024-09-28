import 'package:car_rental_app/model/car.dart';

class Brand{
  final String id;
  final String name;
  final String logoUrl;
  final List<Car> cars;

  Brand( {
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.cars,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      logoUrl: json['logoUrl'],
      cars: json['cars'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
      'cars':cars,
    };
  }
}
