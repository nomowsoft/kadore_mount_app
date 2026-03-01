import 'package:flutter/material.dart';
import 'past_order_card.dart';

class PastOrdersTab extends StatelessWidget {
  const PastOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final pastOrders = [
      {
        'orderNumber': 'KAD-90100',
        'date': '20 ديسمبر 2026',
        'totalAmount': 120.00,
      },
      {
        'orderNumber': 'KAD-90089',
        'date': '15 نوفمبر 2026',
        'totalAmount': 65.50,
      },
      {
        'orderNumber': 'KAD-89950',
        'date': '2 أكتوبر 2026',
        'totalAmount': 210.00,
      },
    ];

    if (pastOrders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'لا توجد طلبات سابقة',
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
      itemCount: pastOrders.length,
      itemBuilder: (context, index) {
        final order = pastOrders[index];
        return PastOrderCard(
          orderNumber: order['orderNumber'] as String,
          date: order['date'] as String,
          totalAmount: order['totalAmount'] as double,
          onReorderTapped: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 8),
                    Text('تم إضافة المنتجات إلى السلة بنجاح'),
                  ],
                ),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                action: SnackBarAction(
                  label: 'عرض السلة',
                  textColor: Colors.white,
                  onPressed: () {
                    // Navigate to cart
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
