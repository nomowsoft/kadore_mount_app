import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  String selectedMethod = 'cash'; // Default

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'طريقة الدفع',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkOliveBlack,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _PaymentCard(
                title: 'الدفع عند\nالاستلام',
                icon: Icons.money,
                isSelected: selectedMethod == 'cash',
                onTap: () => setState(() => selectedMethod = 'cash'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _PaymentCard(
                title: 'بطاقة ائتمان',
                icon: Icons.credit_card,
                isSelected: selectedMethod == 'card',
                onTap: () => setState(() => selectedMethod = 'card'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _PaymentCard(
                title: 'محفظة Apple',
                icon: Icons
                    .account_balance_wallet, // Placeholder for Apple Pay icon
                isSelected: selectedMethod == 'apple_pay',
                onTap: () => setState(() => selectedMethod = 'apple_pay'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
