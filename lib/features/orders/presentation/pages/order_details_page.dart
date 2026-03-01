import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تفاصيل الطلب',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Order header
          Text(
            'طلب #$orderId',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkOliveBlack,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'تم الطلب في 25 ديسمبر 2026، 10:30 صباحاً',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // Items List
          const Text(
            'المنتجات',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildOrderItem(name: 'طماطم طازجة', quantity: 2, price: 15.0),
          _buildOrderItem(name: 'تفاح أحمر', quantity: 1, price: 25.0),
          _buildOrderItem(name: 'موز', quantity: 1, price: 12.0),

          const Divider(height: 32),

          // Summary
          const Text(
            'ملخص الدفع',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow('المجموع', '67.00 ر.س'),
          _buildSummaryRow('الخصم', '-10.00 ر.س', color: Colors.green),
          _buildSummaryRow('رسوم التوصيل', '15.00 ر.س'),
          const Divider(height: 24),
          _buildSummaryRow('الإجمالي', '72.00 ر.س', isBold: true, size: 18),

          const SizedBox(height: 32),

          // Payment Method & Address Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.payment, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text(
                      'طريقة الدفع',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('البطاقة الائتمانية (**** 1234)'),
                const Divider(height: 24),
                const Row(
                  children: [
                    Icon(Icons.location_on, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text(
                      'موقع التوصيل',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('الرياض، حي الملقا، شارع 10'),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Invoice Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.receipt_long),
              label: const Text(
                'عرض الفاتورة',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required String name,
    required int quantity,
    required double price,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${quantity}x',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Text(name, style: const TextStyle(fontSize: 16)),
            ],
          ),
          Text(
            '${price * quantity} ر.س',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
    double size = 14,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: size,
              color: isBold ? AppColors.darkOliveBlack : Colors.grey.shade700,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: size,
              color:
                  color ?? (isBold ? AppColors.darkOliveBlack : Colors.black87),
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
