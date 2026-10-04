import 'package:flutter/material.dart';

import '../data/products_data.dart';
import '../models/product.dart';
import '../widgets/category_chips.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

/// Main discovery / feed screen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _category = 'All';
  String _query = '';
  final Set<String> _favorites = {};
  int _cartCount = 0;

  List<Product> get _filtered => kProducts.where((p) {
        final matchCategory = _category == 'All' || p.category == _category;
        final matchQuery =
            p.name.toLowerCase().contains(_query.toLowerCase().trim());
        return matchCategory && matchQuery;
      }).toList();

  void _toggleFavorite(String id) {
    setState(() {
      if (!_favorites.remove(id)) _favorites.add(id);
    });
  }

  void _addToCart(int qty) => setState(() => _cartCount += qty);

  void _openDetail(Product p) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductDetailScreen(
          product: p,
          isFavorite: _favorites.contains(p.id),
          onToggleFavorite: () => _toggleFavorite(p.id),
          onAddToCart: _addToCart,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = _filtered;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SoleStore',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Cart',
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text('Cart: $_cartCount item(s)'),
                  behavior: SnackBarBehavior.floating,
                ));
            },
            icon: Badge(
              isLabelVisible: _cartCount > 0,
              label: Text('$_cartCount'),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: 'Search sneakers...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              CategoryChips(
                categories: kCategories,
                selected: _category,
                onSelected: (c) => setState(() => _category = c),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${items.length} products',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(Icons.favorite, color: Colors.red, size: 18),
                    const SizedBox(width: 4),
                    Text('${_favorites.length}'),
                  ],
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? const _EmptyState()
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 240,
                          mainAxisExtent: 285,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, i) {
                          final p = items[i];
                          return ProductCard(
                            product: p,
                            isFavorite: _favorites.contains(p.id),
                            onTap: () => _openDetail(p),
                            onFavorite: () => _toggleFavorite(p.id),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 56, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          const Text('Nothing found'),
        ],
      ),
    );
  }
}
