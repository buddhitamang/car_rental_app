import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../services/firestore_service.dart';
import 'car.dart';
import 'brand.dart';

class CarProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  late final List<Brand> _brands = [
    Brand(
      id: '1',
      name: 'Tesla',
      logoUrl: 'https://www.researchgate.net/publication/349493132/figure/fig4/AS:11431281085420770@1663768886900/The-logo-of-Tesla-Inc.png',
      cars: [
        Car(
          id: 'tesla_model_x_1',
          name: 'Tesla Model X',
          description: 'Electric SUV with advanced features',
          imageUrl: 'https://cdn.motor1.com/images/mgl/Mk3qg6/s1/2017-tesla-roadster-deck-model-petersen-automotive-museum.webp',
          seats: '5 seats',
          dailyRate: 100.0,
          enginePower: '670 hp',
          maxSpeed: '155 mph',
          rating: '4.8', // Add rating here
        ),
        Car(
          id: 'tesla_model_s_2',
          name: 'Tesla Model S',
          description: 'Luxury electric sedan',
          imageUrl: 'https://static0.topspeedimages.com/wordpress/wp-content/uploads/jpg/201410/tesla-model-s.jpg',
          seats: '5 seats',
          dailyRate: 120.0,
          enginePower: '1020 hp',
          maxSpeed: '200 mph',
          rating: '4.9', // Add rating here
        ),
        Car(
          id: 'tesla_model_3_3',
          name: 'Tesla Model 3',
          description: 'Affordable electric sedan',
          imageUrl: 'https://cdn.prod.website-files.com/60ce1b7dd21cd517bb39ff20/6165fd676b85a3351aa119e5_tesla_model-s.png',
          seats: '5 seats',
          dailyRate: 80.0,
          enginePower: '283 hp',
          maxSpeed: '140 mph',
          rating: '4.7', // Add rating here
        ),
        Car(
          id: 'tesla_model_y_4',
          name: 'Tesla CyberTruck',
          description: 'Compact electric SUV',
          imageUrl: 'https://cdn.motor1.com/images/mgl/LNZVG/s3/tesla-cybertruck-outdoor-image.jpg',
          seats: '5 seats',
          dailyRate: 90.0,
          enginePower: '450 hp',
          maxSpeed: '135 mph',
          rating: '4.5', // Add rating here
        ),
        Car(
          id: 'tesla_roadster_5',
          name: 'Tesla Roadster',
          description: 'High-performance electric sports car',
          imageUrl: 'https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2017/11/Tesla-Roadster-103.jpg?crop=0.780xw:0.950xh;0.141xw,0.0497xh&resize=768:*',
          seats: '2 seats',
          dailyRate: 150.0,
          enginePower: '1220 hp',
          maxSpeed: '250 mph',
          rating: '4.8', // Add rating here
        ),

      ],
    ),
    Brand(
      id: '2',
      name: 'BMW',
      logoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjFpaOcVOGrsLK6uwqWQLm6sp_pqipm0iIbQ&s',
      cars: [
        Car(
          id: 'bmw_7_series_1',
          name: 'BMW 7 Series',
          description: 'Luxury full-size sedan',
          imageUrl: 'https://mediapool.bmwgroup.com/cache/P9/202204/P90458181/P90458181-the-new-bmw-i7-xdrive60-04-2022-600px.jpg',
          seats: '5 seats',
          dailyRate: 200.0,
          enginePower: '523 hp',
          maxSpeed: '155 mph',
          rating: '4.6', // Add rating here
        ),
        Car(
          id: 'bmw_x7_2',
          name: 'BMW X7',
          description: 'Luxury large SUV',
          imageUrl: 'https://imgd-ct.aeplcdn.com/1056x660/n/cw/ec/136217/x7-facelift-exterior-front-view.jpeg?isig=0&q=80',
          seats: '7 seats',
          dailyRate: 250.0,
          enginePower: '523 hp',
          maxSpeed: '155 mph',
          rating: '4.5', // Add rating here
        ),
        Car(
          id: 'bmw_m3_3',
          name: 'BMW M3',
          description: 'High-performance sports sedan',
          imageUrl: 'https://images.prismic.io/carwow/da024fea-3ccd-4e9a-99d2-aad65bcec58b_2021+BMW+M3+front+quarter+moving+2.jpg?auto=format&cs=tinysrgb&fit=crop&q=60&w=750',
          seats: '5 seats',
          dailyRate: 180.0,
          enginePower: '473 hp',
          maxSpeed: '180 mph',
          rating: '4.7', // Add rating here
        ),
        Car(
          id: 'bmw_i4_4',
          name: 'BMW i4',
          description: 'Electric luxury sedan',
          imageUrl: 'https://imgd.aeplcdn.com/664x374/n/cw/ec/109123/i4-exterior-left-front-three-quarter.jpeg?isig=0&q=80',
          seats: '5 seats',
          dailyRate: 220.0,
          enginePower: '536 hp',
          maxSpeed: '118 mph',
          rating: '4.4', // Add rating here
        ),
      ],
    ),
    Brand(
      id: '3',
      name: 'Audi',
      logoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqBuSD7SaGDf861_6RGYcl0bWBVxJ5qNJ45Q&s',
      cars: [
        Car(
          id: 'audi_q7_1',
          name: 'Audi Q7',
          description: 'Premium large SUV',
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI3PgqXcdh-7ZyzdYB0pNO-J3S5V4virmpGA&s',
          seats: '7 seats',
          dailyRate: 140.0,
          enginePower: '335 hp',
          maxSpeed: '155 mph',
          rating: '4.4', // Add rating here
        ),
        Car(
          id: 'audi_a4_2',
          name: 'Audi A4',
          description: 'Elegant luxury sedan',
          imageUrl: 'https://imgd-ct.aeplcdn.com/664x415/n/cw/ec/51909/a4-exterior-front-view.jpeg?q=80',
          seats: '5 seats',
          dailyRate: 100.0,
          enginePower: '261 hp',
          maxSpeed: '130 mph',
          rating: '4.3', // Add rating here
        ),
        Car(
          id: 'audi_e_tron_3',
          name: 'Audi e-tron',
          description: 'Luxury electric SUV',
          imageUrl: 'https://stimg.cardekho.com/images/carexteriorimages/930x620/Audi/e-tron-GT/8340/1678098767884/front-left-side-47.jpg',
          seats: '5 seats',
          dailyRate: 150.0,
          enginePower: '402 hp',
          maxSpeed: '124 mph',
          rating: '4.5', // Add rating here
        ),
        Car(
          id: 'audi_r8_4',
          name: 'Audi R8',
          description: 'High-performance sports car',
          imageUrl: 'https://www.carandbike.com/_next/image?url=https%3A%2F%2Fimages.carandbike.com%2Fcms%2Farticles%2F2023%2F12%2F3210780%2Fimage_1000x600_84_001c931186.jpg&w=3840&q=75',
          seats: '2 seats',
          dailyRate: 300.0,
          enginePower: '602 hp',
          maxSpeed: '205 mph',
          rating: '4.8', // Add rating here
        ),

      ],
    ),
    Brand(
      id: '4',
      name: 'Ferrari',
      logoUrl: 'https://cdn.vectorstock.com/i/1000v/86/59/ferrari-brand-logo-car-symbol-design-italian-auto-vector-46018659.jpg',
      cars: [
        Car(
          id: 'ferrari_488_gtb_1',
          name: 'Ferrari 488 GTB',
          description: 'High-performance sports car',
          imageUrl: 'https://static01.nyt.com/images/2016/08/05/automobiles/autoreviews/driven-ferrari-488gtb/driven-ferrari-488gtb-superJumbo.jpg',
          seats: '2 seats',
          dailyRate: 300.0,
          enginePower: '661 hp',
          maxSpeed: '211 mph',
          rating: '4.6', // Add rating here
        ),
        Car(
          id: 'ferrari_portofino_2',
          name: 'Ferrari Portofino',
          description: 'Convertible luxury sports car',
          imageUrl: 'https://cdn.ferrari.com/cms/network/media/img/resize/5f60fede966ae519cbd62beb-ferrari-portofino-m-design-hotspot-mob-new_3?',
          seats: '4 seats',
          dailyRate: 350.0,
          enginePower: '591 hp',
          maxSpeed: '199 mph',
          rating: '4.5', // Add rating here
        ),
        Car(
          id: 'ferrari_812_superfast_3',
          name: 'Ferrari 812 Superfast',
          description: 'Powerful V12 sports car',
          imageUrl: 'https://www.mansory.com/sites/default/files/styles/1920x800_fullwidth_car_slider/public/migrated/cars/Cars/ferrari/812/mansory_ferrari_812_stallone_03.jpg?h=1d6ce223&itok=szhTPX0t',
          seats: '2 seats',
          dailyRate: 400.0,
          enginePower: '789 hp',
          maxSpeed: '211 mph',
          rating: '4.9', // Add rating here
        ),
        Car(
          id: 'ferrari_sf90_stradale_4',
          name: 'Ferrari SF90 Stradale',
          description: 'Plug-in hybrid supercar',
          imageUrl: 'https://f1rstmotors.com/_next/image?url=https%3A%2F%2Ff1rst-motors.s3.me-central-1.amazonaws.com%2Fblog%2F1714734880903-blob&w=3840&q=100',
          seats: '2 seats',
          dailyRate: 500.0,
          enginePower: '986 hp',
          maxSpeed: '211 mph',
          rating: '5.0', // Add rating here
        ),

      ],
    ),
  ];

  final List<Brand> _bestCars = [
    Brand(
      id: '1',
      name: 'Tesla',
      logoUrl: '', // Add Tesla logo URL if available
      cars: [
        Car(
          id: 'tesla_model_s_1',
          name: 'Tesla Model S',
          description: 'Luxury electric sedan with advanced features',
          imageUrl: 'https://cdn.motor1.com/images/mgl/Mk3qg6/s1/2017-tesla-roadster-deck-model-petersen-automotive-museum.webp',
          seats: '5 seats',
          dailyRate: 120.0,
          enginePower: '1020 hp',
          maxSpeed: '200 mph',
          rating: '4.8', // Add rating here
        ),
      ],
    ),
    Brand(
      id: '2',
      name: 'BMW',
      logoUrl: '', // Add BMW logo URL if available
      cars: [
        Car(
          id: 'bmw_7_series_1',
          name: 'BMW 7 Series',
          description: 'Luxury full-size sedan',
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwx6900gTBKVp0WaGxh7237YKcYDWpf0OomA&s',
          seats: '5 seats',
          dailyRate: 200.0,
          enginePower: '523 hp',
          maxSpeed: '155 mph',
          rating: '4.5', // Add rating here
        ),
      ],
    ),
    Brand(
      id: '3',
      name: 'Audi',
      logoUrl: '', // Add Audi logo URL if available
      cars: [
        Car(
          id: 'audi_r8_1',
          name: 'Audi R8',
          description: 'High-performance sports car with V10 engine',
          imageUrl: 'https://imgd.aeplcdn.com/370x208/n/cw/ec/141373/q3-sportback-exterior-right-front-three-quarter-2.jpeg?isig=0',
          seats: '2 seats',
          dailyRate: 300.0,
          enginePower: '602 hp',
          maxSpeed: '205 mph',
          rating: '4.9', // Add rating here
        ),
      ],
    ),
    Brand(
      id: '4',
      name: 'Ferrari',
      logoUrl: '', // Add Ferrari logo URL if available
      cars: [
        Car(
          id: 'ferrari_sf90_stradale_1',
          name: 'Ferrari SF90 Stradale',
          description: 'Plug-in hybrid supercar with extreme performance',
          imageUrl: 'https://media.drive.com.au/obj/tx_q:70,rs:auto:448:252:1/driveau/upload/cms/uploads/oH9VFTEdQgirUaT3IxdZ',
          seats: '2 seats',
          dailyRate: 500.0,
          enginePower: '986 hp',
          maxSpeed: '211 mph',
          rating: '5.0', // Add rating here
        ),
      ],
    ),
  ];


  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Method to add best cars to Firestore
  Future<void> addBestCarsToFirestore() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final bestCarsRef = firestore.collection('bestCars');

      for (final brand in _bestCars) {
        final brandRef = bestCarsRef.doc(brand.id);
        await brandRef.set({
          'name': brand.name,
          'logoUrl': brand.logoUrl,
        });

        for (final car in brand.cars) {
          await brandRef.collection('cars').doc(car.id).set({
            'name': car.name,
            'description': car.description,
            'imageUrl': car.imageUrl,
            'seats': car.seats,
            'dailyRate': car.dailyRate,
            'enginePower': car.enginePower,
            'maxSpeed': car.maxSpeed,
            'rating':car.rating
          });
        }
      }
    } catch (e) {
      print('Error adding best cars to Firestore: $e');
    }
  }

  // Method to load best cars from Firestore
  Future<void> loadBestCarsFromFirestore() async {
    try {
      final snapshot = await _firestore.collection('bestCars').get();
      _bestCars.clear();
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final cars = List<Car>.from(
            data['cars'].map((car) => Car.fromJson(car))
        );
        final brand = Brand(
          id: doc.id,
          name: data['name'],
          logoUrl: data['logoUrl'],
          cars: cars,
        );
        _bestCars.add(brand);
      }
      notifyListeners();
    } catch (e) {
      print("Failed to load best cars from Firestore: $e");
    }
  }

  // Method to add a brand to Firestore
  Future<void> addBrandsToFirestore() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (var brand in _brands) {
      // Add each brand as a document
      DocumentReference brandRef = firestore.collection('brands').doc(brand.id);

      await brandRef.set({
        'name': brand.name,
        'logoUrl': brand.logoUrl,
      });

      // Add each car as a subcollection under the brand
      for (var car in brand.cars) {
        await brandRef.collection('cars').doc(car.id).set({
          'name': car.name,
          'description': car.description,
          'imageUrl': car.imageUrl,
          'seats': car.seats,
          'dailyRate': car.dailyRate,
          'enginePower': car.enginePower,
          'maxSpeed': car.maxSpeed,
          'rating':car.rating
        });
      }
    }
  }

  // Future<void> loadAllBrands() async {
  //   try {
  //     _brands = await _firestoreService.fetchAllBrandsWithCars();
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error loading brands: $e');
  //   }
  // }




  int? _curentBrandIndex;
  int? _currentCarIndex;

  int? _currentBestBrandIndex;
  int? _currentBestCarIndex;

  //getter
  List<Brand> get brands => _brands;

  List<Brand> get bestCars => _bestCars;

  int? get currentBrandIndex => _curentBrandIndex;

  int? get currentCarIndex => _currentCarIndex;
  int? get currentBestCarIndex => _currentBestCarIndex;
  int? get currentBestBrandIndex => _currentBestBrandIndex;

  //setter

  set currentBrandIndex(int? newIndex) {
    _curentBrandIndex = newIndex;
    notifyListeners();
  }

  set currentCarIndex(int? newIndex) {
    _currentCarIndex = newIndex;
    notifyListeners();
  }

  set currentBestCarIndex(int? newIndex) {
    _currentBestCarIndex = newIndex;
    notifyListeners();
  }

  set currentBestBrandIndex(int? newIndex) {
    _currentBestBrandIndex = newIndex;
    notifyListeners();
  }
}
