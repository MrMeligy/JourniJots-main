import 'package:flutter/material.dart';

BoxDecoration boxDecorationNavBarElement(
    {required int currentIndex, required int index}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: currentIndex == index ? Colors.white : const Color(0xff8CB6DC),
  );
}
