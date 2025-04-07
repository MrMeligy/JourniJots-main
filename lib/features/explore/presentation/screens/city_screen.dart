import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/explore/presentation/manager/cubits/city_cubit/city_cubit.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city_repo_impl.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_describtion.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/explore_appbar.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/place_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CityScreen extends StatelessWidget {
  const CityScreen(
      {super.key,
      required this.cityImage,
      required this.city,
      required this.desc});
  final String cityImage;
  final String city;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CityCubit(getIt<CityRepoImpl>())..getActivities(city: city),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -25,
              left: 0,
              right: 0,
              child: Hero(
                tag: cityImage,
                child: Image.asset(
                  cityImage, // Background image
                  fit:
                      BoxFit.cover, // Ensure it does not cover the whole screen
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 45.h),

                  // Header Section
                  const ExploreAppBar(),

                  SizedBox(height: 25.h),

                  // Search Bar
                  const SearchBar(),

                  SizedBox(height: 15.h),

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        "Activities",
                        "Hotels",
                        "Restaurants",
                      ].map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context, '/${category.toLowerCase()}');
                            },
                            child: Chip(
                              label: Text(
                                category,
                                style: const TextStyle(color: kprimarycolor),
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(color: kprimarycolor),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 15.h),

                  // Popular Cities Section with Different Background
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: BlocBuilder<CityCubit, CityState>(
                        builder: (context, state) {
                          return (state is CitySuccess)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // City Description
                                    CityDiscribtion(
                                      city: city,
                                      subtitle: desc,
                                    ),

                                    // List of places
                                    ListView.builder(
                                      shrinkWrap:
                                          true, // Allows the ListView to take only the space it needs
                                      physics:
                                          const NeverScrollableScrollPhysics(), // Disable internal scrolling of ListView
                                      itemCount: state.activities.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: PlaceCard(
                                              activityModel:
                                                  state.activities[index]),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : (state is CityFailure)
                                  ? Center(child: Text(state.err))
                                  : Skeletonizer(
                                      ignoreContainers: true,
                                      child: ListView(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: const [
                                          CityDiscribtion(
                                            city: "CityName",
                                            subtitle: 'desc',
                                          ),
                                          SkltPlaceCard(),
                                          SkltPlaceCard(),
                                          SkltPlaceCard(),
                                          SkltPlaceCard(),
                                        ],
                                      ),
                                    );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "  What are you looking for?",
                hintStyle: const TextStyle(color: kprimarycolor),
                suffixIcon: const Icon(Icons.search, color: kprimarycolor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
