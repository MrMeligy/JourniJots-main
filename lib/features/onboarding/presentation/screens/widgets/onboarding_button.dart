import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = kprimarycolor,
    this.borderColor = kprimarycolor,
  });
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomButton(
        text: text,
        backgroundColor: color,
        borderColor: borderColor,
        textColor: Colors.white,
      ),
    );
  }
}
