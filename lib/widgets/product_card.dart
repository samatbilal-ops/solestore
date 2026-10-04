import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/format.dart';
import 'discount_tag.dart';
import 'product_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image takes all remaining height -> no overflow.
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'product-${product.id}',
                    child: ProductImage(url: product.imageUrl),
                  ),
                  if (product.discountPercent != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: DiscountTag(percent: product.discountPercent!),
                    ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      elevation: 1,
                      child: IconButton(
                        iconSize: 20,
                        visualDensity: VisualDensity.compact,
                        tooltip: 'Favorite',
                        onPressed: onFavorite,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: Colors.grey.shade600),
                  ),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          money(product.price),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 2),
                      Text('${product.rating}',
                          style: theme.textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
