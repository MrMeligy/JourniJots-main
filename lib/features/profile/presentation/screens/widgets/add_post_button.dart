import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/add_post/presentation/screens/widgets/create_post_page.dart';

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreatePostPage()),
            );
          },
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
