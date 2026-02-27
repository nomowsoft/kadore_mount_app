import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class LiveMapSection extends StatelessWidget {
  const LiveMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        children: [
          // 1. Placeholder Map Background
          // Ideally this would be a GoogleMap widget, but we'll use an image placeholder for now to match the design aesthetics.
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://static.vecteezy.com/system/resources/previews/000/153/588/original/vector-city-map-background.jpg',
                ), // Placeholder map image
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white54,
                  BlendMode.lighten,
                ),
              ),
            ),
          ),

          // Current location marker placeholder
          Positioned(
            top: 150,
            left: 100,
            child: Icon(
              Icons.location_on,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
          ),

          // Delivery Vehicle marker placeholder
          Positioned(
            top: 180,
            right: 80,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.local_shipping,
                color: AppColors.primary,
                size: 24,
              ),
            ),
          ),

          // 2. Floating ETA Card
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    // ETA Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'وقت الوصول المتوقع',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '١٢ دقيقة إلى موقعك الحالي',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Track Route Button
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.map, size: 18),
                      label: const Text('تتبع المسار'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent[400],
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
