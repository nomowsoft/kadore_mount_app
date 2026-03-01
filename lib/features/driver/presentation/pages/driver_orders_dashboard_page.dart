import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/driver_order_card.dart';

class DriverOrdersDashboardPage extends StatelessWidget {
  const DriverOrdersDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'لوحة تحكم السائق',
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
                  fontSize: 14.0,
                  fontFamily: 'Cairo',
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.0,
                  fontFamily: 'Cairo',
                ),
                tabs: [
                  Tab(text: 'قيد التنفيذ'),
                  Tab(text: 'المكتملة'),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [_InProgressOrdersTab(), _CompletedOrdersTab()],
        ),
      ),
    );
  }
}

class _InProgressOrdersTab extends StatelessWidget {
  const _InProgressOrdersTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        DriverOrderCard(
          orderId: 'KAD-8845',
          customerName: 'سارة خالد',
          location: 'حي الياسمين، الرياض (١.٥ كم)',
          totalItems: 5,
          status: DriverOrderStatus.preparing,
          onActionTapped: () {},
        ),
        DriverOrderCard(
          orderId: 'KAD-8842',
          customerName: 'عبدالله فهد',
          location: 'حي النرجس، الرياض (٢.٠ كم)',
          totalItems: 8,
          status: DriverOrderStatus.delivering,
          onActionTapped: () {},
        ),
      ],
    );
  }
}

class _CompletedOrdersTab extends StatelessWidget {
  const _CompletedOrdersTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'لا توجد طلبات مكتملة اليوم',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
