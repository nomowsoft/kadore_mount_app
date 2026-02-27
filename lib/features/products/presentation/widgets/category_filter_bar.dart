import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = ['الكل', 'خضروات', 'فواكه', 'عروض فقط'];
    // Assuming 'الكل' is the selected one for demo purposes
    final selectedFilter = 'الكل';

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = filters[index] == selectedFilter;
          return Padding(
            padding: const EdgeInsets.only(left: 8.0), // RTL padding
            child: ChoiceChip(
              label: Text(
                filters[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.darkOliveBlack,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.primary,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                ),
              ),
              onSelected: (bool selected) {},
            ),
          );
        },
      ),
    );
  }
}
