import 'package:flutter/material.dart';

import '../widgets/category_filter_bar.dart';
import '../widgets/product_grid_item.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for Products
    final List<Map<String, dynamic>> products = [
      {
        'name': 'طماطم حمراء',
        'price': '6.25 ر.س',
        'weight': '1 كجم تقريباً',
        'availability': 'متوفر',
        'image':
            'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?auto=format&fit=crop&q=80&w=400',
      },
      {
        'name': 'جزر بلدي',
        'price': '4.75 ر.س',
        'oldPrice': '6.00 ر.س',
        'discount': 'خصم 20%',
        'weight': '500 جم تقريباً',
        'availability': 'كمية محدودة',
        'image':
            'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?auto=format&fit=crop&q=80&w=400',
      },
      {
        'name': 'بطاطس طازجة',
        'price': '8.50 ر.س',
        'weight': '1 كجم تقريباً',
        'availability': 'متوفر',
        'image':
            'https://images.unsplash.com/photo-1518977676601-b53f82aba655?auto=format&fit=crop&q=80&w=400',
      },
      {
        'name': 'باذنجان أسود',
        'price': '5.50 ر.س',
        'weight': '1 كجم تقريباً',
        'availability': 'غير متوفر',
        'image':
            'https://images.unsplash.com/photo-1601648764658-cf37e8c89b70?auto=format&fit=crop&q=80&w=400',
      },
      {
        'name': 'خيار محلي',
        'price': '3.75 ر.س',
        'oldPrice': '5.00 ر.س',
        'discount': 'عرض محدود',
        'weight': '1 كجم تقريباً',
        'availability': 'متوفر',
        'image':
            'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?auto=format&fit=crop&q=80&w=400',
      },
      {
        'name': 'بصل أحمر',
        'price': '4.25 ر.س',
        'weight': '1 كجم تقريباً',
        'availability': 'متوفر',
        'image':
            'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?auto=format&fit=crop&q=80&w=400',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المنتجات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const CategoryFilterBar(),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 100, // Space for Bottom Navigation Bar
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio:
                    0.60, // Ensure no overflow from long titles or stock info
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductGridItem(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
