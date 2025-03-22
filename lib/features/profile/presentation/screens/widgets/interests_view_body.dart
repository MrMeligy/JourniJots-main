import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/interest_category_button.dart';

class InterestsViewBody extends StatelessWidget {
  const InterestsViewBody({
    super.key,
    this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.w,
              runSpacing: 12.h,
              children: const [
                InterestCategoryButton(
                  icon: 'assets/images/food.png',
                  label: 'Food',
                ),
                InterestCategoryButton(
                  icon: 'assets/images/night_shows.png',
                  label: 'Night Shows',
                ),
                InterestCategoryButton(
                  icon: 'assets/images/beach.png',
                  label: 'Beach',
                ),
                InterestCategoryButton(
                  icon: 'assets/images/museum.png',
                  label: 'Museums & Art',
                ),
                InterestCategoryButton(
                  icon: 'assets/images/city_exploration.png',
                  label: 'City Exploration',
                ),
                InterestCategoryButton(
                  icon: 'assets/images/diving.png',
                  label: 'Diving & Beach activities',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
