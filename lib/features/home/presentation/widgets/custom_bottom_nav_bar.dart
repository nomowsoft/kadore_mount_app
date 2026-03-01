import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../cart/presentation/pages/cart_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      elevation: 10,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Right Side Items (RTL)
            _buildNavItem(
              index: 0,
              icon: Icons.home_outlined,
              label: 'الرئيسية',
              isSelected: currentIndex == 0,
            ),
            _buildNavItem(
              index: 1,
              icon: Icons.storefront_outlined,
              label: 'المنتجات',
              isSelected: currentIndex == 1,
            ),

            // Empty space for the floating center button
            const SizedBox(width: 48),

            // Left Side Items (RTL)
            _buildNavItem(
              index: 2,
              icon: Icons.favorite_border,
              label: 'المفضلة',
              isSelected: currentIndex == 2,
            ),
            _buildNavItem(
              index: 3,
              icon: Icons.person_outline,
              label: 'حسابي',
              isSelected: currentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    final color = isSelected ? AppColors.primary : Colors.grey[500];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// Separate widget for the Floating Cart Button
class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.sandyGold, // Inner Gold
        border: Border.all(
          color: AppColors.oliveGreen, // Outer Dark Green Ring
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartPage()),
            );
          },
          child: const Center(
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
