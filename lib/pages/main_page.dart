import 'package:car_rental_app/pages/profile_page.dart';
import 'package:car_rental_app/pages/rental_page.dart';
import 'package:car_rental_app/pages/search_page.dart';
import 'package:flutter/material.dart';// Import the custom bottom nav bar
import 'package:car_rental_app/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _navigatePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onNavigate: _navigatePage),
      SearchPage(),
      BookingListPage(),
     ProfilePage(),
    ];

    return Scaffold(
      backgroundColor:Theme.of(context).primaryColor,
      body: pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: _navigatePage,
        ),
      ),
    );
  }
}


class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('home.png', 'Home', 0),
            _buildNavItem('search.png', 'Search', 1),
            _buildNavItem('car-rent.png', 'Rentals', 2),
            _buildNavItem('user.png', 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String imagePath, String label, int index) {
    final bool isSelected = index == selectedIndex;

    return InkWell(
      onTap: () => onItemSelected(index),
      borderRadius: BorderRadius.circular(45),
      splashColor: Colors.blue.withOpacity(0.2), // Ripple effect color
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'lib/icons/$imagePath',
            color: isSelected ? Colors.blue.shade800
                :Colors.grey.shade600,
            width: 25,
            height: 25,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );

  }
}