import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../pages/driver_order_details_page.dart';

enum DriverOrderStatus {
  newOrder('طلب جديد', Colors.blue),
  preparing('جاري التجهيز', Colors.orange),
  delivering('في الطريق', AppColors.primary);

  final String label;
  final Color color;
  const DriverOrderStatus(this.label, this.color);
}

class DriverOrderCard extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String location;
  final int totalItems;
  final DriverOrderStatus status;
  final VoidCallback? onActionTapped;

  const DriverOrderCard({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.location,
    required this.totalItems,
    required this.status,
    this.onActionTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DriverOrderDetailsPage(
              orderId: orderId,
              customerName: customerName,
              status: status,
              location: location,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Status Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: status.color.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_long, color: status.color, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'طلب #$orderId',
                        style: TextStyle(
                          color: status.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: status.color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Order Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInfoRow(Icons.person, customerName),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.location_on, location),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.shopping_bag, '$totalItems منتجات'),
                ],
              ),
            ),

            const Divider(height: 1),

            // Actions
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildActionButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.darkOliveBlack,
            ),
          ),
        ),
      ],
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
        actionText = 'تأكيد التسليم';
        actionColor = AppColors.primary;
        break;
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onActionTapped,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: actionColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          actionText,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
