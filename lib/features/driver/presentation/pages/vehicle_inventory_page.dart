import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class VehicleInventoryPage extends StatelessWidget {
  const VehicleInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مخزون المركبة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildInventorySection(
            title: 'تنبيهات نقص المخزون',
            items: [
              _InventoryItem(
                name: 'طماطم محمي بالكيلو',
                currentQty: 2,
                isLow: true,
              ),
              _InventoryItem(
                name: 'خيار طازج بالكيلو',
                currentQty: 5,
                isLow: true,
              ),
            ],
            isAlertSection: true,
          ),
          const SizedBox(height: 24),
          _buildInventorySection(
            title: 'المخزون المتوفر',
            items: [
              _InventoryItem(
                name: 'بصل أحمر يمني بالكيلو',
                currentQty: 45,
                isLow: false,
              ),
              _InventoryItem(
                name: 'بطاطس بلدي بالكيلو',
                currentQty: 30,
                isLow: false,
              ),
              _InventoryItem(
                name: 'جزر بلدي مستورد بالكيلو',
                currentQty: 20,
                isLow: false,
              ),
              _InventoryItem(
                name: 'فلفل رومي أخضر بالكيلو',
                currentQty: 15,
                isLow: false,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.sync, color: Colors.white),
        label: const Text(
          'تحديث المخزون',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildInventorySection({
    required String title,
    required List<_InventoryItem> items,
    bool isAlertSection = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isAlertSection) ...[
              const Icon(Icons.warning_amber_rounded, color: Colors.red),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isAlertSection ? Colors.red : AppColors.darkOliveBlack,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: item.isLow
                        ? Colors.red.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${item.currentQty} كجم',
                    style: TextStyle(
                      color: item.isLow ? Colors.red : AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _InventoryItem {
  final String name;
  final int currentQty;
  final bool isLow;

  _InventoryItem({
    required this.name,
    required this.currentQty,
    required this.isLow,
  });
}
