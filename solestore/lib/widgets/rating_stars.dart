import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int reviews;
  const RatingStars({super.key, required this.rating, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (i) {
          final icon = rating >= i + 1
              ? Icons.star
              : rating > i
                  ? Icons.star_half
                  : Icons.star_border;
          return Icon(icon, color: Colors.amber, size: 20);
        }),
        const SizedBox(width: 8),
        // Flexible: text shrinks instead of overflowing on narrow screens.
        Flexible(
          child: Text(
            '$rating ($reviews reviews)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
