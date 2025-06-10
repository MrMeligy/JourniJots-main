import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  final bool? isSelected;
  const CategoryChip({
    super.key,
    required this.category,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        category,
        style: TextStyle(
            color: (isSelected ?? false)
                ? kbodycolor
                : const Color.fromARGB(255, 78, 127, 182)),
      ),
      backgroundColor: (isSelected ?? false)
          ? const Color.fromARGB(255, 78, 127, 182)
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Color.fromARGB(255, 78, 127, 182)),
      ),
    );
  }
}
