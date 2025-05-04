import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/explore/presentation/manager/cubits/city_cubit/city_cubit.dart';
import 'package:journijots/features/explore/presentation/manager/cubits/places_count/places_count_cubit.dart';
import 'package:journijots/features/explore/presentation/manager/repos/places_count/places_count_repo_imol.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/category_chip.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/category_count.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_places.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_describtion.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_skeltonizer.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/search_bar.dart';

class CityScreen extends StatefulWidget {
  const CityScreen(
      {super.key,
      required this.cityImage,
      required this.city,
      required this.desc});
  final String cityImage;
  final String city;
  final String desc;

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String selectedCategory = "Activities"; // default
  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });

    if (category == "Activities") {
      context.read<CityCubit>().getActivities(city: widget.city, pageNum: '1');
    } else if (category == "Restaurants") {
      context.read<CityCubit>().getRestaurants(city: widget.city, pageNum: '1');
    } else if (category == "Hotels") {
      context.read<CityCubit>().getHotels(city: widget.city, pageNum: '1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlacesCountCubit(getIt<PlacesCountRepoImol>())
        ..getPlacesCount(city: widget.city),
      child: Scaffold(
        backgroundColor: kscaffoldcolor,
        body: Stack(
          children: [
            Positioned(
              top: -25,
              left: 0,
              right: 0,
              child: Hero(
                tag: widget.cityImage,
                child: Image.asset(
                  widget.cityImage, // Background image
                  fit:
                      BoxFit.cover, // Ensure it does not cover the whole screen
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 70.h),
                  // Header Section
                  // const ExploreAppBar(),
                  // SizedBox(height: 25.h),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: CustomSearchBar(
                      city: widget.city,
                      hintText: "Search in ${widget.city}",
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Popular Cities Section with Different Background

                  BlocBuilder<PlacesCountCubit, PlacesCountState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          ClipPath(
                            clipper:
                                OvalTopBorderClipper(), // أو جرّب WaveClipperTwo، WaveClipperOneReverse ...
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: double.infinity,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  CityDiscribtion(
                                    city: widget.city,
                                    subtitle: widget.desc,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: (state is PlacesCountSuccess)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CategoryCount(
                                                category: "Activities",
                                                image:
                                                    "assets/icons/Activities.png",
                                                count: state.placesCount
                                                        .activitiesCount ??
                                                    0,
                                              ),
                                              CategoryCount(
                                                category: "Restaurants",
                                                image:
                                                    "assets/icons/Restaurants.png",
                                                count: state.placesCount
                                                        .restaurantsCount ??
                                                    0,
                                              ),
                                              CategoryCount(
                                                category: "Hotels",
                                                image:
                                                    "assets/icons/Hotels.png",
                                                count: state.placesCount
                                                        .hotelsCount ??
                                                    0,
                                              ),
                                            ],
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: BlocBuilder<CityCubit, CityState>(
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Row(
                                          spacing: 5,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () => _onCategorySelected(
                                                  "Activities"),
                                              child: CategoryChip(
                                                category: "Activities",
                                                isSelected: selectedCategory ==
                                                    "Activities",
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => _onCategorySelected(
                                                  "Restaurants"),
                                              child: CategoryChip(
                                                category: "Restaurants",
                                                isSelected: selectedCategory ==
                                                    "Restaurants",
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  _onCategorySelected("Hotels"),
                                              child: CategoryChip(
                                                category: "Hotels",
                                                isSelected: selectedCategory ==
                                                    "Hotels",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      (state is CitySuccess)
                                          ? Column(
                                              children: [
                                                CityPlaces(
                                                  city: widget.city,
                                                  desc: widget.desc,
                                                  places: state.places,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 30.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor: (state
                                                                    .pagDetails
                                                                    .pageNumber ==
                                                                1)
                                                            ? kscaffoldcolor
                                                            : kprimarycolor,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            if (state.pagDetails
                                                                    .pageNumber ==
                                                                1) {
                                                              return;
                                                            }
                                                            _prevPage(
                                                                context, state);
                                                          },
                                                          icon: Icon(
                                                              Icons
                                                                  .arrow_back_ios_new,
                                                              size: 30.h,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor: (state
                                                                .pagDetails
                                                                .hasNext!)
                                                            ? kprimarycolor
                                                            : kscaffoldcolor,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            if (!state
                                                                .pagDetails
                                                                .hasNext!) {
                                                              return;
                                                            }
                                                            _nextPage(
                                                                context, state);
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 30.h,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30.h,
                                                )
                                              ],
                                            )
                                          : (state is CityFailure)
                                              ? Center(child: Text(state.err))
                                              : const CitySkeltonizer(),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _nextPage(BuildContext context, CitySuccess state) {
    if (selectedCategory == "Activities") {
      context.read<CityCubit>().getActivities(
          city: widget.city,
          pageNum: (state.pagDetails.pageNumber! + 1).toString());
    } else if (selectedCategory == "Restaurants") {
      context.read<CityCubit>().getRestaurants(
          city: widget.city,
          pageNum: (state.pagDetails.pageNumber! + 1).toString());
    } else if (selectedCategory == "Hotels") {
      context.read<CityCubit>().getHotels(
          city: widget.city,
          pageNum: (state.pagDetails.pageNumber! + 1).toString());
    }
  }

  void _prevPage(BuildContext context, CitySuccess state) {
    if (selectedCategory == "Activities") {
      context.read<CityCubit>().getActivities(
          city: widget.city,
          pageNum: (state.pagDetails.pageNumber! - 1).toString());
    } else if (selectedCategory == "Restaurants") {
      context.read<CityCubit>().getRestaurants(
          city: widget.city,
          pageNum: (state.pagDetails.pageNumber! - 1).toString());
    } else if (selectedCategory == "Hotels") {
      context.read<CityCubit>().getHotels(
          city: widget.city,
          pageNum: (state.pagDetails.pageNumber! - 1).toString());
    }
  }
}
