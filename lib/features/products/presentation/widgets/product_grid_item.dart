import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ProductGridItem extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductGridItem({super.key, required this.product});

  @override
  State<ProductGridItem> createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount = widget.product['oldPrice'] != null;
    final String availability = widget.product['availability'] as String;

    Color availabilityColor;
    if (availability == 'متوفر') {
      availabilityColor = Colors.green;
    } else if (availability == 'كمية محدودة') {
      availabilityColor = Colors.orange;
    } else {
      availabilityColor = Colors.grey;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.product['image'] as String,
                        fit: BoxFit.cover,
                      ),
                      // Availability Overlay if out of stock
                      if (availability == 'غير متوفر')
                        Container(color: Colors.white.withValues(alpha: 0.6)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Availability Status
                    Text(
                      availability,
                      style: TextStyle(
                        color: availabilityColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.product['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.product['weight'] as String,
                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                    ),
                    const SizedBox(height: 8),
                    // Price Row
                    Row(
                      children: [
                        Text(
                          widget.product['price'] as String,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        if (hasDiscount) ...[
                          const SizedBox(width: 4),
                          Text(
                            widget.product['oldPrice'] as String,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Add to cart or Quantity selector
                    if (availability != 'غير متوفر')
                      SizedBox(
                        height: 32,
                        child: quantity == 0
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      quantity = 1;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'أضف للسلة',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: AppColors.primary,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                  Text(
                                    '$quantity',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 0) quantity--;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      color: AppColors.primary,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // Favorite Icon
          Positioned(
            top: 8,
            left: 8, // RTL
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white70,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ),

          // Discount Badge
          if (hasDiscount)
            Positioned(
              top: 8,
              right: 8, // RTL
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.product['discount'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
