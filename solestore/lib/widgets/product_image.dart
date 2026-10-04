import 'package:flutter/material.dart';

/// Network image with loading indicator and a safe fallback,
/// so a missing/slow image never breaks the layout.
class ProductImage extends StatelessWidget {
  final String url;
  const ProductImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const ColoredBox(
          color: Color(0xFFEDEDF0),
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
      errorBuilder: (context, error, stack) => const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD9C9), Color(0xFFFFB38F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Icon(Icons.directions_run, size: 48, color: Colors.white),
        ),
      ),
    );
  }
}
