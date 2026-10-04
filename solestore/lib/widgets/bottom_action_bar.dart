import 'package:flutter/material.dart';

import '../utils/format.dart';

/// Sticky bottom bar: total price, quantity stepper and a full-width
/// "Add to Cart" button (Expanded).
class BottomActionBar extends StatelessWidget {
  final double total;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  const BottomActionBar({
    super.key,
    required this.total,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 12,
      color: theme.colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text('Total', style: theme.textTheme.bodyMedium),
                      const Spacer(),
                      Text(
                        money(total),
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton.outlined(
                        onPressed: onRemove,
                        tooltip: 'Decrease',
                        icon: const Icon(Icons.remove),
                      ),
                      SizedBox(
                        width: 36,
                        child: Text(
                          '$quantity',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      IconButton.outlined(
                        onPressed: onAdd,
                        tooltip: 'Increase',
                        icon: const Icon(Icons.add),
                      ),
                      const SizedBox(width: 12),
                      // Button takes ALL remaining width.
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: onAddToCart,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                          ),
                          icon: const Icon(Icons.shopping_cart_outlined),
                          label: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Add to Cart'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
