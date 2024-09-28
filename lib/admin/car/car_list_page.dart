import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/car.dart';
import '../../model/car_provider.dart';

class CarListPage extends StatelessWidget {
  final String category;

  CarListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Cars - $category'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to car form page to add a new car
            },
          ),
        ],
      ),
      body: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          List<Car> cars;
          if (category == 'Best Cars') {
            cars = carProvider.bestCars.expand((brand) => brand.cars).toList();
          } else {
            cars = carProvider.brands.expand((brand) => brand.cars).toList();
          }

          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return ListTile(
                leading: car.imageUrl != null
                    ? Image.network(
                  car.imageUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : Icon(Icons.directions_car),
                title: Text('${car.name}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: \$${car.dailyRate}'),
                    Text('Engine Power: ${car.enginePower}'),
                    Text('Max Speed: ${car.maxSpeed}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navigate to car form page to edit the car
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Handle delete operation
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
