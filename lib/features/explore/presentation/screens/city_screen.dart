import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/features/explore/presentation/manager/cubits/city_cubit/city_cubit.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/category_chip.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_activites.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_describtion.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_hotels.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_restaurants.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_skeltonizer.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/explore_appbar.dart';
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
      context.read<CityCubit>().getActivities(city: widget.city);
    } else if (category == "Restaurants") {
      context.read<CityCubit>().getRestaurants(city: widget.city);
    } else if (category == "Hotels") {
      context.read<CityCubit>().getHotels(city: widget.city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                fit: BoxFit.cover, // Ensure it does not cover the whole screen
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: CustomSearchBar(
                    city: widget.city,
                    hintText: "Search in ${widget.city}",
                  ),
                ),
                SizedBox(height: 15.h),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => _onCategorySelected("Activities"),
                        child: CategoryChip(
                          category: "Activities",
                          isSelected: selectedCategory == "Activities",
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _onCategorySelected("Restaurants"),
                        child: CategoryChip(
                          category: "Restaurants",
                          isSelected: selectedCategory == "Restaurants",
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _onCategorySelected("Hotels"),
                        child: CategoryChip(
                          category: "Hotels",
                          isSelected: selectedCategory == "Hotels",
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15.h),

                // Popular Cities Section with Different Background
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        return Column(
                          children: [
                            CityDiscribtion(
                              city: widget.city,
                              subtitle: widget.desc,
                            ),
                            (state is CityActivitiesSuccess)
                                ? CityActivties(
                                    city: widget.city,
                                    desc: widget.desc,
                                    activities: state.activities,
                                  )
                                : (state is CityRestaurantsSuccess)
                                    ? CityRestaurants(
                                        city: widget.city,
                                        desc: widget.desc,
                                        restaurants: state.restaurants)
                                    : (state is CityHotelsSuccess)
                                        ? CityHotels(
                                            city: widget.city,
                                            desc: widget.desc,
                                            hotels: state.hotels,
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
            ),
          ),
        ],
      ),
    );
  }
}
