import 'package:flutter/material.dart';
import 'active_order_card.dart';
import '../pages/order_tracking_page.dart';

class ActiveOrdersTab extends StatelessWidget {
  const ActiveOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final activeOrders = [
      {
        'orderNumber': 'KAD-90123',
        'status': OrderStatus.onTheWay,
        'eta': '15 دقيقة',
        'totalAmount': 145.50,
      },
      {
        'orderNumber': 'KAD-90124',
        'status': OrderStatus.preparing,
        'eta': '45 دقيقة',
        'totalAmount': 89.00,
      },
    ];

    if (activeOrders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_rounded, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'لا توجد طلبات حالية',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: activeOrders.length,
      itemBuilder: (context, index) {
        final order = activeOrders[index];
        return ActiveOrderCard(
          orderNumber: order['orderNumber'] as String,
          status: order['status'] as OrderStatus,
          eta: order['eta'] as String,
          totalAmount: order['totalAmount'] as double,
          onTrackTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    OrderTrackingPage(orderId: order['orderNumber'] as String),
              ),
            );
          },
        );
      },
    );
  }
}
