import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solestore/main.dart';
import 'package:solestore/widgets/product_card.dart';

/// Proves "zero RenderFlex overflow" on small, normal and large screens.
void main() {
  const sizes = <Size>[
    Size(320, 568), // very small phone
    Size(375, 812), // normal phone
    Size(768, 1024), // tablet
    Size(1280, 800), // desktop / web
  ];

  for (final size in sizes) {
    testWidgets('no overflow + interactions at ${size.width}x${size.height}',
        (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const ShopApp());
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull);

      // Home: favorite toggle (setState).
      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pump();
      expect(find.byIcon(Icons.favorite), findsWidgets);

      // Open detail screen.
      await tester.tap(find.byType(ProductCard).first);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      expect(find.text('Product Preview'), findsOneWidget);

      // Quantity counter (setState).
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      // Bookmark toggle (setState).
      await tester.tap(find.byIcon(Icons.bookmark_border));
      await tester.pump();
      expect(find.byIcon(Icons.bookmark), findsOneWidget);

      expect(tester.takeException(), isNull);
    });
  }
}
