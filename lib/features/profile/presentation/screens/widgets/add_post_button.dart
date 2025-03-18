import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';

class AddPostButton extends StatelessWidget {
  const AddPostButton({
    super.key,
    required bool isVisible,
    required this.onPressed,
  }) : _isVisible = isVisible;

  final bool _isVisible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: _isVisible ? 1.0 : 0.0,
      child: Align(
        alignment: Alignment(1.w, 1.08.h),
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: kprimarycolor,
          child: const Icon(
            Icons.create,
            color: kbodycolor,
            size: 28,
          ),
        ),
      ),
    );
  }
}
