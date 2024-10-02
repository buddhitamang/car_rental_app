import 'dart:convert';
import 'dart:io';

import 'package:car_rental_app/components/best_car.dart';
import 'package:car_rental_app/components/brands.dart';
import 'package:car_rental_app/components/custom_drawer.dart';
import 'package:car_rental_app/components/nearby_car.dart';
import 'package:car_rental_app/components/recommended_car.dart';
import 'package:car_rental_app/model/car_provider.dart';
import 'package:car_rental_app/pages/brand_cars_page.dart';
import 'package:car_rental_app/pages/car_details_page.dart';
import 'package:car_rental_app/pages/login_or_register_page.dart';
import 'package:car_rental_app/pages/main_page.dart';
import 'package:car_rental_app/pages/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/brand.dart';
import '../model/car.dart';
import '../services/firestore_service.dart';
import '../services/search_provider.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String? welcomeName;
  final Function(int) onNavigate;

  const HomePage({super.key, this.welcomeName, required this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _searchFocusNode = FocusNode();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int _selectedIndex = 0;

  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        widget.onNavigate(0);
        break;
      case 1:
        widget.onNavigate(1);
        break;
      case 2:
        widget.onNavigate(2);
        break;
      case 3:
        widget.onNavigate(3);
        break;
      case 4:
        // // Sign out the user
        //   signOut();
        break;
      default:
        widget.onNavigate(0); // Default is Home
    }
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        widget.onNavigate(1);
      }
    });
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.loadRecommendedCars();
    // final carProvider = Provider.of<CarProvider>(context, listen: false);
    // carProvider.loadAllBrands();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  bool _showAllNearbyCars = false;

  @override
  Widget build(BuildContext context) {
    final CarProvider carProvider = Provider.of<CarProvider>(context);

    // Combine all cars from all brands
    final List<Car> allNearbyCars =
        carProvider.brands.expand((brand) => brand.cars).toList();

    // Limit the list to 4 cars if _showAllNearbyCars is false
    final List<Car> carsToShow =
        _showAllNearbyCars ? allNearbyCars : allNearbyCars.take(4).toList();

    final searchProvider = Provider.of<SearchProvider>(context);

    void _showSortingOptions() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.sort_by_alpha),
                  title: Text('Sort by Name'),
                  onTap: () {
                    // Implement sorting by name
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.attach_money),
                  title: Text('Sort by Price'),
                  onTap: () {
                    // Implement sorting by price
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Sort by Rating'),
                  onTap: () {
                    // Implement sorting by rating
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    void navigateCarDetailsPage(Car car) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarDetailsPage(car: car),
        ),
      );
    }

    File? _selectedImage;

    Future<void> _pickImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    }

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
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    void signOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        // Navigate to login page or show a success message
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginOrRegisterPage()), // Replace with your login page widget
        );
      } catch (e) {
        // Show an error message if sign-out fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-out failed: ${e.toString()}')),
        );
      }
    }

    final FirestoreService _firestoreService = FirestoreService();
    List _brands = [];
    List _bestCars = [];
    Future<void> _loadData() async {
      try {
        _brands = await _firestoreService.fetchAllBrandsWithCars();
        _bestCars = await _firestoreService.fetchBestCars();
        setState(() {}); // Trigger rebuild to show the data
      } catch (e) {
        print('Error loading data: $e');
      }
    }

    final User? currentUser = FirebaseAuth.instance.currentUser;

    Future<List<Car>> getRecommendedCars(String brandName) async {
      // Map brand names to their respective IDs
      final brandIdMap = {
        'tesla': '1',
        'bmw': '2',
        'audi': '3',
        'ferrari': '4',
      };

      final brandId = brandIdMap[brandName.toLowerCase()]; // Convert brand name to lowercase

      if (brandId == null) {
        print('No brand found for the name: $brandName');
        return []; // Return empty list if no valid brand ID is found
      }

      try {
        // Fetch cars from Firestore
        final carsSnapshot = await FirebaseFirestore.instance
            .collection('brands')
            .doc(brandId)
            .collection('cars')
            .get();

        // Convert snapshot to a list of Car objects
        final recommendedCars = carsSnapshot.docs.map((doc) {
          final data = doc.data();
          return Car.fromJson(data); // Ensure Car.fromJson handles your data structure
        }).toList();

        print('Cars fetched: $recommendedCars'); // Log fetched cars
        return recommendedCars;
      } catch (e) {
        print('Error fetching cars: $e');
        return []; // Return empty list in case of an error
      }
    }









    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: CustomDrawer(
        onItemSelected: (int index) {
          _onDrawerItemSelected(index);
        },
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  currentUser?.email ?? 'no user',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18),
              // Search and Sorting
              Row(
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'searchTag',
                      child: TextField(
                        readOnly: true,
                        focusNode: _searchFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Search your dream car...',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.primary,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  GestureDetector(
                    onTap: _showSortingOptions,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                      child: Icon(Icons.sort,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              // Brands List
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('brands').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No brands found.'));
                  }

                  final brandsDocs = snapshot.data!.docs;

                  // Map Firestore documents to Brand objects
                  final List<Brand> brandList = brandsDocs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return Brand(
                      id: doc.id,
                      name: data['name'],
                      logoUrl: data['logoUrl'],
                      cars: [], // You may want to fetch cars separately
                    );
                  }).toList();

                  return Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: brandList.length,
                      itemBuilder: (context, index) {
                        final brand = brandList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BrandCarsPage(brand: brand),
                              ),
                            );
                          },
                          child: Brands(
                            imagePath: brand.logoUrl,
                            brandName: brand.name,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: 18),
              // Best Cars Section
              Container(
                height: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Best Cars',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color,
                            ),
                          ),
                          Text(
                            'View All',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('bestCars')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(child: Text('No best cars found.'));
                          }

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final brandDoc = snapshot.data!.docs[index];
                              return StreamBuilder<QuerySnapshot>(
                                stream: brandDoc.reference
                                    .collection('cars')
                                    .snapshots(),
                                builder: (context, carSnapshot) {
                                  if (carSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (!carSnapshot.hasData ||
                                      carSnapshot.data!.docs.isEmpty) {
                                    return SizedBox.shrink();
                                  }

                                  // Assuming you want the first car
                                  final carData = carSnapshot.data!.docs[0]
                                      .data() as Map<String, dynamic>;
                                  final car = Car.fromJson(
                                      carData); // Assuming you create a fromMap constructor

                                  return GestureDetector(
                                    onTap: () => navigateCarDetailsPage(car),
                                    child: BestCar(
                                      carName: car.name,
                                      seatCapacity: car.seats,
                                      rate: car.dailyRate.toString(),
                                      imagePath: car.imageUrl,
                                      rating: car.rating,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 18,),
              // Recommended cars section
              searchProvider.lastSearchedBrand.isEmpty
                  ? SizedBox()
                  : FutureBuilder<List<Car>>(
                future: getRecommendedCars(searchProvider.lastSearchedBrand),
                builder: (context, snapshot) {
                  print('Fetching recommended cars for brand: ${searchProvider.lastSearchedBrand}');

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 8),
                          Text('Loading recommendations...'),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No recommendations available for this brand.'));
                  }

                  final recommendedCars = snapshot.data!;
                  print('Recommended Cars: $recommendedCars');

                  return Container(
                    height: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Recommended Cars',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Theme.of(context).textTheme.displayLarge?.color,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: recommendedCars.length,
                            itemBuilder: (context, index) {
                              final car = recommendedCars[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CarDetailsPage(car: car),
                                    ),
                                  );
                                },
                                child: RecommendedCar(
                                  carName: car.name,
                                  seatCapacity: car.seats,
                                  rate: car.dailyRate.toString(),
                                  imagePath: car.imageUrl,
                                  rating: car.rating,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),



              SizedBox(height: 18),
              // All Cars Section with Grid View
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Show all the cars',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color:
                            Theme.of(context).textTheme.displayMedium?.color),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showAllNearbyCars = !_showAllNearbyCars;
                      });
                    },
                    child: Text(
                      _showAllNearbyCars ? 'Show Less' : 'View All',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

// StreamBuilder to fetch all nearby cars
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('brands').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No brands found.'));
                  }

                  final brandDocs = snapshot.data!.docs;
                  // List to hold the nearby cars (cleared for each build)
                  List<Car> allNearbyCars = [];

                  return FutureBuilder<void>(
                    future: Future.forEach(brandDocs, (brandDoc) async {
                      final carSnapshot = await brandDoc.reference.collection('cars').get();
                      final cars = carSnapshot.docs.map((carDoc) {
                        final carData = carDoc.data() as Map<String, dynamic>;
                        return Car(
                          id: carDoc.id,
                          name: carData['name'] ?? 'Unknown',
                          seats: carData['seats']?.toString() ?? '0',
                          dailyRate: (carData['dailyRate'] as num?)?.toDouble() ?? 0.0,
                          imageUrl: carData['imageUrl'] ?? 'default_image_url',
                          description: carData['description'] ?? '',
                          enginePower: carData['enginePower'] ?? '',
                          maxSpeed: carData['maxSpeed'] ?? '',
                          rating: carData['rating']?.toString() ?? '0.0',
                        );
                      }).toList();
                      allNearbyCars.addAll(cars);
                    }),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (allNearbyCars.isEmpty) {
                        return Center(child: Text('No nearby cars found.'));
                      }

                      // Limit the number of cars shown if needed
                      final carsToShow = _showAllNearbyCars
                          ? allNearbyCars
                          : allNearbyCars.take(4).toList();

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 5,
                        ),
                        itemCount: carsToShow.length,
                        itemBuilder: (context, index) {
                          final car = carsToShow[index];
                          return GestureDetector(
                            onTap: () {
                              navigateCarDetailsPage(car);
                            },
                            child: NearbyCar(
                              imagePath: car.imageUrl,
                              carName: car.name,
                              seatCapacity: '${car.seats} ',
                              rate: '\$${car.dailyRate}',
                              rating: car.rating ?? '0.0',
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
