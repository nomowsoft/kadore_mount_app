import 'package:flutter/material.dart';

import '../../../cart/presentation/pages/cart_page.dart';
import '../widgets/category_list_section.dart';
import '../widgets/live_map_section.dart';
import '../widgets/product_carousel_section.dart';
import '../widgets/promotional_banner_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow map to go behind app bar
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    );
                  },
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Section 1: Live Map
          SliverToBoxAdapter(child: LiveMapSection()),

          // Section 2: Categories
          SliverToBoxAdapter(child: CategoryListSection()),

          // Section 3: Promotional Banner
          SliverToBoxAdapter(child: PromotionalBannerSection()),

          // Section 4: Suggested Products
          SliverToBoxAdapter(child: ProductCarouselSection(title: 'مقترح لك')),

          // Section 5: New & Featured Items
          SliverToBoxAdapter(
            child: ProductCarouselSection(title: 'وصل حديثاً'),
          ),

          // Spacer for Bottom Navigation Bar
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
