class Booking {
  final String id;
  final String userId;
  final String carId;
  final DateTime startDate;
  final DateTime endDate;
  final String status; // e.g., "Pending", "Confirmed", "Cancelled"
  final double totalPrice;
  final String fullName;
  final String phoneNumber;
  // final String currentUser;

  Booking( {
    required this.id,
    required this.userId,
    required this.carId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalPrice,
    required this.fullName,
    required this.phoneNumber,
    // required this.currentUser,
  });

  // Convert Booking to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'carId': carId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'totalPrice':totalPrice,
      'fullName':fullName,
      'phoneNumber':phoneNumber,
      // 'currentUser':currentUser,
    };
  }

  // Convert Map to Booking
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      userId: map['userId'],
      carId: map['carId'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      status: map['status'],
      totalPrice: (map['price'] != null) ? (map['totalPrice'] as num).toDouble() : 0.0,
      fullName: map['fullName'] ?? 'Anonymous', // Provide a default full name
      phoneNumber: map['phoneNumber'] ?? 'Unknown',
      // currentUser: map['currentUser'],
    );
  }
}
