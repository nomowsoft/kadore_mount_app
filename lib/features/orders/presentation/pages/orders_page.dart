import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/active_orders_tab.dart';
import '../widgets/past_orders_tab.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'طلباتي',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: Container(
              color: Colors.white,
              child: const TabBar(
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primary,
                indicatorWeight: 3.0,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  fontFamily: 'Cairo',
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                  fontFamily: 'Cairo',
                ),
                tabs: [
                  Tab(text: 'الطلبات الحالية'),
                  Tab(text: 'الطلبات السابقة'),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(children: [ActiveOrdersTab(), PastOrdersTab()]),
      ),
    );
  }
}
