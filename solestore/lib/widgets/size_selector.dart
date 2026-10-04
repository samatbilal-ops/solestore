import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  final List<int> sizes;
  final int? selected;
  final ValueChanged<int> onSelected;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final s in sizes)
          ChoiceChip(
            label: Text('$s'),
            selected: selected == s,
            onSelected: (_) => onSelected(s),
          ),
      ],
    );
  }
}
