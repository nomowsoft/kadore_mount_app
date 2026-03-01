import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// Placeholders for the actual pages we will build next
import 'driver_orders_dashboard_page.dart';
import 'vehicle_inventory_page.dart';
import 'driver_order_history_page.dart';

class DriverMainNavigationPage extends StatefulWidget {
  const DriverMainNavigationPage({super.key});

  @override
  State<DriverMainNavigationPage> createState() =>
      _DriverMainNavigationPageState();
}

class _DriverMainNavigationPageState extends State<DriverMainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DriverOrdersDashboardPage(),
    const VehicleInventoryPage(),
    const DriverOrderHistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 11,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining_outlined),
              activeIcon: Icon(Icons.delivery_dining),
              label: 'الطلبات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: 'المخزون',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: 'السجل',
            ),
          ],
        ),
      ),
    );
  }
}
