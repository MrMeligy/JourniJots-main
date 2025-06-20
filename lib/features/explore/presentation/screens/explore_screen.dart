import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/explore/presentation/manager/cubits/city_cubit/city_cubit.dart';
import 'package:journijots/features/explore/presentation/manager/cubits/near_places/nearplaces_cubit.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city/city_repo_impl.dart';
import 'package:journijots/features/explore/presentation/manager/repos/nearby_places/nearby_places_repo_imp.dart';
import 'package:journijots/features/explore/presentation/screens/city_screen.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/nearby_place_card.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/popular_cities_swiper.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/search_bar.dart';
import 'package:journijots/features/place/presentation/manager/place_cubit/place_cubit.dart';
import 'package:journijots/features/place/presentation/manager/repos/place_repo_impl.dart';
import 'package:journijots/features/place/presentation/screens/place_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NearplacesCubit(getIt<NearbyPlacesRepoImp>())
            ..getNearPlaces(
              city: getIt<CacheHelper>().getData(key: ApiKey.city),
            ),
        ),
        BlocProvider(
          create: (context) => PlaceCubit(
            getIt<PlaceRepoImpl>(),
          ),
        ),
      ],
      child: Scaffold(
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
                            color: const Color.fromARGB(255, 49, 128, 192),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 57, 130, 189),
                                Color.fromARGB(255, 163, 210, 252),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.explore_rounded,
                            color: Colors.white,
                            size: 23,
                          ),
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
                  // Replace the existing Container with this enhanced version
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // Clean white background
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      // Add subtle shadow for depth
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade100.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                          spreadRadius: 0,
                        ),
                      ],
                      // Add subtle border
                      border: Border(
                        top: BorderSide(
                          color: Colors.blue.shade100.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        // Inner decoration for layered effect
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        // Subtle inner glow
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.8),
                            blurRadius: 10,
                            offset: const Offset(0, 1),
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Enhanced Section Title with decorative elements
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // Decorative icon
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 57, 130, 189),
                                          Color.fromARGB(255, 163, 210, 252),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.location_city,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Enhanced title
                                  Text(
                                    "Popular Cities",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff8CB6DC),
                                      shadows: [
                                        Shadow(
                                          color: Colors.blue.shade100,
                                          offset: const Offset(0, 1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),

                          // Existing PopularCitiesSwiper (unchanged)
                          const PopularCitiesSwiper(),
                          SizedBox(height: 30.h),

                          // Enhanced Nearby Places Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    // Location pin icon
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 57, 130, 189),
                                            Color.fromARGB(255, 163, 210, 252),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.place,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Popular Places in ${getIt<CacheHelper>().getData(key: ApiKey.city)}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff8CB6DC),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Enhanced "See more" button
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (_) =>
                                            CityCubit(getIt<CityRepoImpl>())
                                              ..getActivities(
                                                city: getIt<CacheHelper>()
                                                    .getData(key: ApiKey.city),
                                                pageNum: '1',
                                              ),
                                        child: Builder(
                                          builder: (context) {
                                            final String cityName =
                                                getIt<CacheHelper>()
                                                    .getData(key: ApiKey.city);

                                            CardItem? cityData;
                                            for (var card in kcitycards) {
                                              if (card.title.toLowerCase() ==
                                                  cityName.toLowerCase()) {
                                                cityData = card;
                                                break;
                                              }
                                            }

                                            cityData ??= kcitycards.first;

                                            return CityScreen(
                                              city: cityName.replaceFirst(
                                                  cityName[0],
                                                  cityName[0].toUpperCase()),
                                              cityImage: cityData.imagePath,
                                              desc: cityData.subtitle,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 57, 130, 189),
                                        Color.fromARGB(255, 163, 210, 252),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "See more",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          // Existing BlocBuilder (unchanged functionality)
                          BlocBuilder<NearplacesCubit, NearplacesState>(
                            builder: (context, state) {
                              if (state is NearplacesSuccess) {
                                return SizedBox(
                                  height:
                                      230.h, // Fixed height for the ListView
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.places.length,
                                    itemBuilder: (context, index) {
                                      return nearPlaceCard(state.places[index],
                                          () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PlaceScreen(
                                              placeId: state.places[index].id,
                                              city: getIt<CacheHelper>()
                                                  .getData(key: ApiKey.city),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  height: 200.h,
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 55.h),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
