import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/features/profile/presentation/manager/profile_posts_cubit/profile_posts_cubit.dart';
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
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return (state is ProfileSuccess)
                ? (state.profileModel.interests!.isNotEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 12.h,
                            children: state.profileModel.interests!
                                .map((interest) =>
                                    InterestCategoryButton(interest: interest))
                                .toList(),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 12.h,
                            children: const [
                              InterestCategoryButton(
                                  interest: "Nature Adventures"),
                              InterestCategoryButton(
                                  interest: "Local Food Experiences"),
                              InterestCategoryButton(
                                  interest: "Night Activities & Light Shows"),
                              InterestCategoryButton(
                                  interest: "Mountain Adventures & Hiking"),
                              InterestCategoryButton(
                                  interest: "Historic Mosques & Churches"),
                              InterestCategoryButton(
                                  interest: "Ancient Fortresses & Castles"),
                              InterestCategoryButton(
                                  interest: "Island Trips & Beach Escapes"),
                              InterestCategoryButton(
                                  interest: "Traditional Markets & Souvenirs"),
                              InterestCategoryButton(
                                  interest: "Relaxation & Resorts"),
                              InterestCategoryButton(
                                  interest: "Hot Air Balloon Rides"),
                              InterestCategoryButton(
                                  interest: "Astronomical Observations"),
                              InterestCategoryButton(
                                  interest: "Scuba Diving & Snorkeling"),
                              InterestCategoryButton(
                                  interest: "Egyptian Monuments"),
                              InterestCategoryButton(interest: "Desert Safari"),
                              InterestCategoryButton(
                                  interest: "Nubian Culture"),
                              InterestCategoryButton(
                                  interest: "Cultural City Tours"),
                              InterestCategoryButton(
                                  interest: "Historical Tourism"),
                            ],
                          )
                        ],
                      )
                : const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
