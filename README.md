# SoleStore 👟

A Flutter sneaker marketplace app. **Capstone Project — Milestone 1 (MVP UI)** and **Lab 5 (Adaptive Item Detail Screen)**.

## Problem & Target User
**Problem:** [Your words. Example: Choosing sneakers online means switching between many sites to compare price, rating and size.]

**Target user:** [Your words. Example: Students and young adults who want to discover, favorite and order sneakers quickly in one clean app.]

## Screenshots
| Home / Feed | Product Preview |
|---|---|
| ![Home](docs/home.png) | ![Detail](docs/detail.png) |

## Features
**Home / Feed screen**
- Search field and category chips (All, Running, Lifestyle, Basketball, Training)
- Responsive product grid (2–5 columns depending on screen width)
- Favorite ❤️ toggle on each card and a favorites counter
- Cart badge in the app bar

**Product Preview screen (Lab 5)**
- `Stack` cover image with discount badge and bookmark badge
- Title and price in a `Row` with `Expanded`
- Star rating and category badges in a `Wrap`
- Size selector and expandable description
- Sticky bottom action bar: quantity stepper and full-width **Add to Cart** button (`Expanded`)

## Interactivity (`StatefulWidget` + `setState`)
- Search and category filter
- Favorite and bookmark toggles
- Quantity counter, size selection, "Read more" toggle
- Cart counter updated from the detail screen

## Zero RenderFlex Overflow
- `Expanded` / `Flexible` for text inside rows
- `Wrap` for badges and sizes
- `SingleChildScrollView` on the detail screen
- Grid with `maxCrossAxisExtent`, `maxWidth` constraints on large screens
- Text scale clamped to 1.3×
- Automated test at 320×568, 375×812, 768×1024 and 1280×800 (`flutter test`)

## Project Structure
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

## How to Run
```bash
git clone https://github.com/samatbilal-ops/solestore.git
cd solestore
flutter pub get
flutter run -d chrome
flutter test
```

## Roadmap
- Milestone 2: REST API (real products)
- Milestone 3: local database (favorites, cart)
- Milestone 4: BLoC architecture

## Author
Samat Bilal — [Course name], Narxoz University
