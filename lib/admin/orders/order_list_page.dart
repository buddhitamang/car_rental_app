import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order {
  final String id;
  final String carId;
  final String customerName;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.carId,
    required this.customerName,
    required this.orderDate,
  });

  factory Order.fromDocument(DocumentSnapshot doc) {
    return Order(
      id: doc.id,
      carId: doc['carId'],
      customerName: doc['customerName'],
      orderDate: (doc['orderDate'] as Timestamp).toDate(),
    );
  }
}

class OrderListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Orders'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to order form page to add a new order
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final orders = snapshot.data?.docs.map((doc) => Order.fromDocument(doc)).toList() ?? [];

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Text('Order for ${order.customerName}'),
                subtitle: Text('Date: ${order.orderDate.toLocal().toString().split(' ')[0]}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navigate to order form page to edit the order
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Handle delete operation
                        FirebaseFirestore.instance.collection('orders').doc(order.id).delete();
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
