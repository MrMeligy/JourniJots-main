import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.text,
      required this.backgroundColor,
      required this.borderColor,
      required this.textColor});
  String text;
  Color backgroundColor;
  Color borderColor;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor, width: 1),
      ),
      width: width / 1.3,
      height: 50.h,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
