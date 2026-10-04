import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/format.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/category_badge.dart';
import '../widgets/discount_tag.dart';
import '../widgets/product_image.dart';
import '../widgets/rating_stars.dart';
import '../widgets/size_selector.dart';

/// Product Preview / detail screen (Lab 5).
class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final ValueChanged<int> onAddToCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late bool _bookmarked = widget.isFavorite;
  int _quantity = 1;
  int? _size;
  bool _expanded = false;

  Product get product => widget.product;

  void _toggleBookmark() {
    setState(() => _bookmarked = !_bookmarked);
    widget.onToggleFavorite();
  }

  void _increment() => setState(() => _quantity++);

  void _decrement() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  void _addToCart() {
    final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    if (_size == null) {
      messenger.showSnackBar(const SnackBar(
        content: Text('Please select a size'),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    widget.onAddToCart(_quantity);
    messenger.showSnackBar(SnackBar(
      content: Text('Added $_quantity × size $_size to cart'),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Product Preview')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCover(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitlePriceRow(theme),
                        const SizedBox(height: 10),
                        RatingStars(
                          rating: product.rating,
                          reviews: product.reviews,
                        ),
                        const SizedBox(height: 16),
                        Text('Categories', style: theme.textTheme.titleSmall),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final t in product.tags) CategoryBadge(t),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text('Select size', style: theme.textTheme.titleSmall),
                        const SizedBox(height: 8),
                        SizeSelector(
                          sizes: product.sizes,
                          selected: _size,
                          onSelected: (s) => setState(() => _size = s),
                        ),
                        const SizedBox(height: 20),
                        Text('Description', style: theme.textTheme.titleSmall),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          maxLines: _expanded ? null : 3,
                          overflow: _expanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () =>
                                setState(() => _expanded = !_expanded),
                            child: Text(_expanded ? 'Show less' : 'Read more'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.local_shipping_outlined,
                                color: theme.colorScheme.primary),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Free delivery · 2–3 business days',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        total: product.price * _quantity,
        quantity: _quantity,
        onAdd: _increment,
        onRemove: _decrement,
        onAddToCart: _addToCart,
      ),
    );
  }

  // Stack: cover image + discount badge + bookmark badge.
  Widget _buildCover() {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'product-${product.id}',
            child: ProductImage(url: product.imageUrl),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [Colors.black38, Colors.transparent],
              ),
            ),
          ),
          if (product.discountPercent != null)
            Positioned(
              top: 12,
              left: 12,
              child: DiscountTag(percent: product.discountPercent!),
            ),
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 2,
              child: IconButton(
                onPressed: _toggleBookmark,
                tooltip: 'Bookmark',
                icon: Icon(
                  _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: _bookmarked ? Colors.deepOrange : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Row: title (Expanded) + price column.
  Widget _buildTitlePriceRow(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            product.name,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              money(product.price),
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (product.oldPrice != null)
              Text(
                money(product.oldPrice!),
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
