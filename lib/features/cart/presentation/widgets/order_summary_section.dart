import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OrderSummarySection extends StatelessWidget {
  final double subtotal;
  final double vat;
  final double discount;
  final double total;

  const OrderSummarySection({
    super.key,
    required this.subtotal,
    required this.vat,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.receipt_long, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'ملخص الطلب',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkOliveBlack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SummaryRow(title: 'المجموع الفرعي', amount: subtotal),
          const SizedBox(height: 8),
          _SummaryRow(title: 'ضريبة القيمة المضافة (15%)', amount: vat),
          const SizedBox(height: 8),
          _SummaryRow(
            title: 'خصم العروض',
            amount: discount,
            isDiscount: true,
            icon: Icons.local_offer_outlined,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(color: Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الإجمالي النهائي',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkOliveBlack,
                ),
              ),
              Text(
                '${total.toStringAsFixed(2)} ر.س',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final double amount;
  final bool isDiscount;
  final IconData? icon;

  const _SummaryRow({
    required this.title,
    required this.amount,
    this.isDiscount = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDiscount ? AppColors.sandyGold : Colors.grey[800];
    final amountText = isDiscount
        ? '- ${amount.toStringAsFixed(2)} ر.س'
        : '${amount.toStringAsFixed(2)} ر.س';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
            ],
            Text(title, style: TextStyle(color: color, fontSize: 13)),
          ],
        ),
        Text(
          amountText,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: isDiscount ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
