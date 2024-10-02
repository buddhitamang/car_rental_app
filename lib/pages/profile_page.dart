import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:car_rental_app/components/profile_container.dart';
import 'package:car_rental_app/components/profile_setting_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage; // Class member for the selected image
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final String name = (FirebaseAuth.instance.currentUser?.email?.split('@').first) ?? 'Guest';

  // List of Profile Settings
  final List profileContainer = [
    [Icons.person, 'Username', 'buddhitamang107@gmail.com', Icons.arrow_forward_ios_rounded],
    [Icons.settings, 'Settings', 'App settings', Icons.arrow_forward_ios_rounded],
    [Icons.help, 'Help and Support', 'Support Service',],
  ];

  // Fetches the count of orders with the specified status
  Stream<int> _getOrderCount(String status) {
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: currentUser!.uid)
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) {
      final count = snapshot.docs.length;
      print('Query for status $status returned $count documents.'); // Debugging line
      return count;
    });
  }

  // Function to pick an image from the selected source
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Display Image Picker Modal
  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Choose what you want',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Menu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Theme.of(context).textTheme.displayLarge?.color,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Add logout functionality here
                          },
                          icon: Icon(Icons.search_outlined, size: 34),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Profile Picture and User Information
            Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : AssetImage('lib/assets/demo.png') as ImageProvider,
                      backgroundColor: Colors.yellow,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => showImagePicker(context),
                        icon: Icon(Icons.camera_alt, color: Colors.grey.shade200),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  '$name',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  currentUser?.email ?? 'No User',
                  style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.displayMedium?.color),
                ),
              ],
            ),
            SizedBox(height: 26),

            // Status Containers
            Container(
              height: 130,
              child: Row(
                children: [
                  Expanded(
                    child: StreamBuilder<int>(
                      stream: _getOrderCount('active'), // Stream for active orders
                      builder: (context, snapshot) {
                        final activeCount = snapshot.data ?? 0; // Default to 0 if null
                        return ProfileContainer(
                          number: '$activeCount', // Displaying active order count
                          title: 'Active',
                          backgroundColor: Colors.deepPurpleAccent.shade100,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<int>(
                      stream: _getOrderCount('Pending'), // Stream for pending orders
                      builder: (context, snapshot) {
                        final pendingCount = snapshot.data ?? 0; // Default to 0 if null
                        return ProfileContainer(
                          number: '$pendingCount', // Displaying pending order count
                          title: 'Pending',
                          backgroundColor: Theme.of(context).colorScheme.surface,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<int>(
                      stream: _getOrderCount('complete'), // Stream for completed orders
                      builder: (context, snapshot) {
                        final completeCount = snapshot.data ?? 0; // Default to 0 if null
                        return ProfileContainer(
                          number: '$completeCount', // Displaying completed order count
                          title: 'Complete',
                          backgroundColor: Theme.of(context).colorScheme.surface,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 27),

            // Profile Settings List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: profileContainer.length,
                    itemBuilder: (context, index) {
                      return ProfileSettingContainer(
                        leadingIcon: profileContainer[index][0],
                        title: profileContainer[index][1],
                        subTitle: profileContainer[index][2],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
