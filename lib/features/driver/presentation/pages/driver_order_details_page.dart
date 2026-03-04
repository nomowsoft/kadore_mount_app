import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/driver_order_card.dart';
import 'driver_delivery_map_page.dart';

class DriverOrderDetailsPage extends StatelessWidget {
  final String orderId;
  final String customerName;
  final DriverOrderStatus status;
  final String location;

  const DriverOrderDetailsPage({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.status,
    required this.location,
  });

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
          // Basic Info
          _buildSectionCard(
            title: 'معلومات العميل',
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    customerName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(location),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.phone, color: AppColors.primary),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary.withValues(
                            alpha: 0.1,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.map, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DriverDeliveryMapPage(
                                driverId:
                                    1, // TODO: Replace with actual driver ID
                                orderId:
                                    int.tryParse(
                                      orderId.replaceAll(RegExp(r'[^0-9]'), ''),
                                    ) ??
                                    0,
                                customerName: customerName,
                                customerAddress: location,
                                customerLocation: const LatLng(
                                  24.7136, // TODO: Replace with actual customer lat
                                  46.6753, // TODO: Replace with actual customer lng
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const Row(
                  children: [
                    Icon(Icons.notes, color: Colors.grey, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'ملاحظة: الرجاء الاتصال عند الوصول، الباب الجانبي.',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Products
          _buildSectionCard(
            title: 'قائمة المنتجات (٥)',
            child: Column(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'طماطم محمي بالكيلو',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'الكمية: ٢',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Payment Details
          _buildSectionCard(
            title: 'تفاصيل الدفع',
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'طريقة الدفع',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Row(
                  children: [
                    Icon(Icons.money, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'الدفع عند الاستلام',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Large Action Button
          _buildActionButtons(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkOliveBlack,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    String actionText;
    Color actionColor;
    Color textColor = Colors.white;

    switch (status) {
      case DriverOrderStatus.newOrder:
        actionText = 'استلام الطلب';
        actionColor = Colors.blue;
        break;
      case DriverOrderStatus.preparing:
        actionText = 'بدء التوصيل';
        actionColor = AppColors.sandyGold;
        textColor = AppColors.darkOliveBlack;
        break;
      case DriverOrderStatus.delivering:
        actionText = 'تأكيد التسليم (تم استلام المبلغ)';
        actionColor = AppColors.primary;
        break;
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: actionColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          actionText,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
