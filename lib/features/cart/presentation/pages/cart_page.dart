import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/order_summary_section.dart';
import '../widgets/payment_method_section.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for Cart Items
    final List<Map<String, dynamic>> cartItems = [
      {
        'name': 'طماطم طازجة',
        'price': '20.00 ر.س',
        'weight': '1 كجم',
        'quantity': 2,
        'image':
            'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?auto=format&fit=crop&q=80&w=400',
      },
      {
        'name': 'خيار بلدي',
        'price': '15.00 ر.س',
        'weight': '1 كجم',
        'quantity': 3,
        'image':
            'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?auto=format&fit=crop&q=80&w=400',
      },
      {
        'name': 'تفاح أحمر',
        'price': '12.00 ر.س',
        'weight': '1 كجم',
        'quantity': 1,
        'image':
            'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&q=80&w=400',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'سلة التسوق',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.sandyGold,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'توصيل إلى: حي النخيل، الرياض',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'تغيير',
                    style: TextStyle(
                      color: AppColors.sandyGold.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'المنتجات المختارة (3)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkOliveBlack,
              ),
            ),
            const SizedBox(height: 16),
            // Cart Items
            ...cartItems.map((item) => CartItemCard(item: item)),

            const SizedBox(height: 16),
            // Order Summary
            const OrderSummarySection(
              subtotal: 47.00,
              vat: 7.05,
              discount: 5.00,
              total: 49.05,
            ),

            const SizedBox(height: 24),
            // Payment Method
            const PaymentMethodSection(),

            const SizedBox(height: 100), // Space for bottom button
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // Dark Green
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.delivery_dining),
            label: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'تأكيد الطلب',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Text(
                  'إرسال لأقرب متجر',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
