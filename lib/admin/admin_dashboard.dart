import 'package:flutter/material.dart';

import 'car/car_list_page.dart';
import 'orders/order_list_page.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String _selectedCarCategory = 'Other Cars'; // Default category
  Widget _currentPage = CarListPage(category: 'Other Cars'); // Default page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Admin Dashboard'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Admin Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Manage Cars'),
              trailing: DropdownButton<String>(
                value: _selectedCarCategory,
                items: <String>['Best Cars', 'Other Cars']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCarCategory = newValue!;
                    _currentPage = CarListPage(category: _selectedCarCategory);
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Manage Orders'),
              onTap: () {
                setState(() {
                  _currentPage = OrderListPage();
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: _currentPage,
    );
  }
}
