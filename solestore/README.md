# SoleStore 👟

Flutter sneaker marketplace — **Capstone Project, Milestone 1 (MVP UI)** + **Lab 5** (Adaptive Item Detail Screen).

**Problem:** buying sneakers online means jumping between many sites to compare price, rating and size.
**Users:** students and young adults who want to quickly discover, favorite and order sneakers from one clean app.

## Features (Milestone 1)
| Screen | What it shows |
|---|---|
| **Home / Feed** | Search, category chips (tab toggle), responsive product grid, favorite ❤️ counter, cart badge |
| **Product Preview** (Lab 5) | `Stack` cover + discount & bookmark badges, `Row` title/price, star rating, `Wrap` category badges, size selector, sticky bottom bar with full-width **Add to Cart** (`Expanded`) |

### Interactivity (`StatefulWidget` + `setState`)
- Search + category filter
- Favorite toggle on cards, bookmark on detail screen
- Quantity counter, size selection, "Read more" toggle, cart counter

### Zero RenderFlex overflow
- `Expanded` / `Flexible` for text in rows, `Wrap` for badges and sizes
- `SingleChildScrollView` on detail screen
- `maxCrossAxisExtent` grid → 2…5 columns automatically
- `maxWidth` constraints on tablets / web, text scale clamped to 1.3×
- Automated proof: `flutter test` runs at 320×568, 375×812, 768×1024, 1280×800

## Project structure
```
lib/
├── main.dart
├── theme/app_theme.dart
├── models/product.dart
├── data/products_data.dart
├── utils/format.dart
├── screens/
│   ├── home_screen.dart
│   └── product_detail_screen.dart
└── widgets/
    ├── product_card.dart
    ├── product_image.dart
    ├── category_chips.dart
    ├── category_badge.dart
    ├── rating_stars.dart
    ├── size_selector.dart
    ├── discount_tag.dart
    └── bottom_action_bar.dart
test/overflow_test.dart
```

## Run
```bash
flutter create . --platforms=android,ios,web   # generates platform folders (keeps lib/ and pubspec)
flutter pub get
flutter run
flutter test
```

## Roadmap
- Milestone 2: REST API (real products)
- Milestone 3: local database (favorites, cart)
- Milestone 4: BLoC architecture
