import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/category_chip.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/category_count.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_describtion.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_skeltonizer.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/trip_places.dart';
import 'package:journijots/features/trip/presentation/managers/cubits/trip_places_cubit/trip_places_cubit.dart';
import 'package:journijots/features/trip/presentation/managers/repos/trip_places_repo/trip_places_repo_impl.dart';

class TripPlacesScreen extends StatefulWidget {
  const TripPlacesScreen({
    super.key,
    required this.city,
    required this.tripId,
  });
  final int tripId;
  final String city;

  @override
  State<TripPlacesScreen> createState() => _TripPlacesScreenState();
}

class _TripPlacesScreenState extends State<TripPlacesScreen> {
  String selectedCategory = "Activities"; // default
  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });

    if (category == "Activities") {
      // context.read<CityCubit>().getActivities(city: widget.city, pageNum: '1');
    } else if (category == "Restaurants") {
      // context.read<CityCubit>().getRestaurants(city: widget.city, pageNum: '1');
    } else if (category == "Hotels") {
      // context.read<CityCubit>().getHotels(city: widget.city, pageNum: '1');
    }
  }

  String get cityImage {
    final String imagePath;
    if (widget.city == "Cairo") {
      imagePath = "assets/images/cities/cairo.jpg";
    } else if (widget.city == "Giza") {
      imagePath = "assets/images/cities/giza.png";
    } else if (widget.city == "Alexandria") {
      imagePath = "assets/images/cities/alex copy.png";
    } else if (widget.city == "Dahab") {
      imagePath = "assets/images/cities/Dahab.jpg";
    } else if (widget.city == "Taba") {
      imagePath = "assets/images/cities/Taba.jpg";
    } else if (widget.city == "Luxor") {
      imagePath = "assets/images/cities/luxur.png";
    } else if (widget.city == "Aswan") {
      imagePath = "assets/images/cities/Aswan.webp";
    } else if (widget.city == "Sharm Elsheikh") {
      imagePath = "assets/images/cities/SharmElshiekh.jpg";
    } else if (widget.city == "Hurghada") {
      imagePath = "assets/images/cities/Hurghada.jpg";
    } else if (widget.city == "Alamin") {
      imagePath = "assets/images/cities/Alamien.jpg";
    } else if (widget.city == "Port Said") {
      imagePath = "assets/images/cities/PortSaid.webp";
    } else if (widget.city == "Suez") {
      imagePath = "assets/images/cities/Suez.jpg";
    } else if (widget.city == "Marsa Alam") {
      imagePath = "assets/images/cities/MarsaAlam.jpg";
    } else {
      imagePath = "assets/images/cities/Fayoum.jpg";
    }
    return imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TripPlacesCubit(getIt<TripPlacesRepoImpl>())
        ..getTripPlaces(tripId: widget.tripId),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 134, 166, 193),
        body: Stack(
          children: [
            Positioned(
              top: -25,
              left: 0,
              right: 0,
              child: Image.asset(
                cityImage, // Background image
                fit: BoxFit.cover, // Ensure it does not cover the whole screen
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
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xff149FEA),
                          child: IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Popular Cities Section with Different Background

                  BlocBuilder<TripPlacesCubit, TripPlacesState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          ClipPath(
                            clipper: OvalTopBorderClipper(),
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
                                    subtitle:
                                        "Explore Your Plan in ${widget.city}",
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: (state is TripPlacesSuccess)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CategoryCount(
                                                category: "Activities",
                                                image:
                                                    "assets/icons/Activities.png",
                                                count: state.tripPlaces
                                                        .activities?.length ??
                                                    0,
                                              ),
                                              CategoryCount(
                                                category: "Restaurants",
                                                image:
                                                    "assets/icons/Restaurants.png",
                                                count: state.tripPlaces
                                                        .restaurants?.length ??
                                                    0,
                                              ),
                                              CategoryCount(
                                                category: "Hotels",
                                                image:
                                                    "assets/icons/Hotels.png",
                                                count: state.tripPlaces.hotels
                                                        ?.length ??
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
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 45),
                                    child: Row(
                                      spacing: 10,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              _onCategorySelected("Activities"),
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
                                            isSelected:
                                                selectedCategory == "Hotels",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  (state is TripPlacesSuccess)
                                      ? Column(
                                          children: [
                                            // Show message if selected category is empty
                                            if (selectedCategory ==
                                                    "Activities" &&
                                                (state.tripPlaces.activities ==
                                                        null ||
                                                    state.tripPlaces.activities!
                                                        .isEmpty))
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.0),
                                                child: Text(
                                                  'There is no Activities in your plan',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            if (selectedCategory ==
                                                    "Restaurants" &&
                                                (state.tripPlaces.restaurants ==
                                                        null ||
                                                    state.tripPlaces
                                                        .restaurants!.isEmpty))
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.0),
                                                child: Text(
                                                  'There is no Restaurants in your plan',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            if (selectedCategory == "Hotels" &&
                                                (state.tripPlaces.hotels ==
                                                        null ||
                                                    state.tripPlaces.hotels!
                                                        .isEmpty))
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.0),
                                                child: Text(
                                                  'There is no Hotels in your plan',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            TripPlaces(
                                              city: widget.city,
                                              desc:
                                                  "Explore Your Plan in ${widget.city}",
                                              activities: (selectedCategory ==
                                                      "Activities")
                                                  ? state.tripPlaces.activities!
                                                  : null,
                                              restaurants: (selectedCategory ==
                                                      "Restaurants")
                                                  ? state
                                                      .tripPlaces.restaurants!
                                                  : null,
                                              hotels:
                                                  (selectedCategory == "Hotels")
                                                      ? state.tripPlaces.hotels!
                                                      : null,
                                            ),
                                            SizedBox(
                                              height: 30.h,
                                            )
                                          ],
                                        )
                                      : (state is TripPlacesFailure)
                                          ? Center(
                                              child: Text(state.toString()))
                                          : const CitySkeltonizer(),
                                ],
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
}
