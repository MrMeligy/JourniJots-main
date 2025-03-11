import 'package:flutter/material.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/nearby_place_card.dart';

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
                  const SizedBox(height: 45),

                  // Header Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/jj.png', // Logo
                          height: 30,
                        ),
                        Text(
                          'Explore',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        const Icon(Icons.notifications,
                            color: Colors.white, size: 28),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "  What are you looking for?",
                              hintStyle:
                                  const TextStyle(color: Color(0xff8CB6DC)),
                              suffixIcon:
                                  const Icon(Icons.search, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Category Filters (Scrollable Chips)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        "Hotels",
                        "Restaurants",
                        "Museums",
                        "Hospitals"
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
                                style:
                                    const TextStyle(color: Color(0xff8CB6DC)),
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side:
                                    const BorderSide(color: Color(0xff8CB6DC)),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 15),

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
                            Text(
                              "See more..",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff8CB6DC)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Stacked Images
                        Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: 20,
                                right: 40,
                                child: Image.asset('assets/images/Frame 13.png',
                                    width: 300, height: 250),
                              ),
                              Positioned(
                                top: -20,
                                left: 35,
                                child: Image.asset('assets/images/Frame 12.png',
                                    width: 300, height: 250),
                              ),
                              // Top image
                              Image.asset('assets/images/Frame 11.png',
                                  width: 300, height: 250),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

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
                        const SizedBox(height: 10),

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
                        const SizedBox(height: 55),
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
