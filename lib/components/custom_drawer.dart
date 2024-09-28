import 'package:car_rental_app/pages/login_or_register_page.dart';
import 'package:car_rental_app/pages/profile_page.dart';
import 'package:car_rental_app/pages/rental_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';
import '../pages/search_page.dart';
import '../themes/theme_provider.dart';

class CustomDrawer extends StatefulWidget {
  final Function(int) onItemSelected;

  CustomDrawer({required this.onItemSelected});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        children: [
          // Drawer Header
          UserAccountsDrawerHeader(
            accountName: Text(currentUser?.displayName ?? 'User Name'),
            accountEmail: Text(currentUser?.email ?? 'No user found',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('lib/assets/loginimage.jpeg'),
              child: Icon(Icons.person, size: 50),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface
            ),
          ),
          // Drawer Items
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              widget.onItemSelected(0); // Update body content
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
            onTap: () {
              widget.onItemSelected(1); // Update body content
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              widget.onItemSelected(2); // Update body content
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              widget.onItemSelected(3); // Update body content
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: themeProvider.isDarkMode?Text('Light Mode'):Text('Dark Mode'),
            trailing: Switch(
              value: themeProvider.isDarkMode, // Get current theme mode
              onChanged: (value) {
                themeProvider.toggleTheme(value); // Toggle theme based on switch
              },
            ),
          ),

          Spacer(),
          // Drawer Footer
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              signOut();
            },
          ),
        ],
      ),
    );
  }

  void signOut() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:  Theme.of(context).colorScheme.surface,
          title: Text('Are you sure you want to logout?'),
          content: Text('You will be logged out from your account.',style: TextStyle(color:  Theme.of(context).textTheme.displayLarge?.color),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without signing out
              },
              child: Text('Cancel',style: TextStyle(color:  Theme.of(context).textTheme.displaySmall?.color),),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginOrRegisterPage(),
                  ),
                );
              },
              child: Text('Logout',style: TextStyle(color:  Theme.of(context).textTheme.displaySmall?.color),),
            ),
          ],
        );
      },
    );
  }
}
