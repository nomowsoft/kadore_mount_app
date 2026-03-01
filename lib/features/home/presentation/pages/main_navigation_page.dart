import 'package:flutter/material.dart';

import '../../../products/presentation/pages/products_page.dart';
import '../../../orders/presentation/pages/orders_page.dart';
import 'home_page.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  // The pages that correspond to each bottom nav item
  final List<Widget> _pages = [
    const HomePage(),
    const ProductsPage(), // We can reuse the existing ProductsPage directly!
    const OrdersPage(), // Replaced Favorites with Orders
    const Center(child: Text('حسابي')), // Placeholder for Account
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody:
          true, // Important for the floating button to bleed over properly
      body: IndexedStack(index: _currentIndex, children: _pages),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingCartButton(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
