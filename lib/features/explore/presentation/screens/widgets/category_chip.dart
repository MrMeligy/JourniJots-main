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
            color: (isSelected ?? false) ? kbodycolor : kprimarycolor),
      ),
      backgroundColor: (isSelected ?? false) ? kprimarycolor : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: kprimarycolor),
      ),
    );
  }
}
