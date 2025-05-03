import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/features/chatbot/peresntation/screens/widgets/suggestion_button.dart';

class SuggestionChips extends StatelessWidget {
  const SuggestionChips({
    super.key,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutQuart),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SuggestionButton(
              icon: Icons.restaurant,
              text: 'Best restaurants in Luxor',
              color: Colors.orange[800]!),
          SizedBox(height: 16.h),
          const SuggestionButton(
              icon: Icons.location_city,
              text: 'Popular attractions in Cairo',
              color: Colors.blue),
          SizedBox(height: 16.h),
          const SuggestionButton(
              icon: Icons.hotel,
              text: '5-star hotels in Sharm El Sheikh',
              color: Colors.teal),
        ],
      ),
    );
  }
}
