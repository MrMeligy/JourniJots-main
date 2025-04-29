import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/nearby_place_card.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/popular_cities_swiper.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/search_bar.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: -25,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/expolre.png', // Background image
              fit: BoxFit.cover, // Ensure it does not cover the whole screen
            ),
          ),

          // Main Content (Make it Scrollable)
          SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom), // Handle keyboard overflow
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 45.h),

                  // Header Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/jj.png', // Logo
                        ),
                        Text(
                          'Explore',
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        Icon(
                          Icons.notifications_on_outlined,
                          size: 35.h,
                          color: kprimarycolor,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Search Bar
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomSearchBar(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25.h),
                  // Popular Cities Section with Different Background
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Title and "See More"
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Cities",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff8CB6DC)),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),

                        // Stacked Images
                        const PopularCitiesSwiper(),
                        SizedBox(height: 30.h),

                        // Nearby Places Section
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nearby Places",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff8CB6DC)),
                            ),
                            Text(
                              "See more..",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff8CB6DC)),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        // Horizontal Scrollable Cards
                        const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              NearbyPlaceCard(
                                  imagePath:
                                      'assets/images/americana-plaza.jpg',
                                  title: 'Americana Plaza',
                                  location: 'Sheikh Zayed City'),
                              NearbyPlaceCard(
                                  imagePath:
                                      'assets/images/Al-Hosary Mosque - 6th October City....JPG',
                                  title: 'El Hosary Mosque',
                                  location: '6th of October City'),
                              NearbyPlaceCard(
                                  imagePath:
                                      'assets/images/americana-plaza.jpg',
                                  title: 'Mall of Egypt',
                                  location: '6th of October City'),
                            ],
                          ),
                        ),
                        SizedBox(height: 55.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
