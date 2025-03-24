import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';

// ignore: use_key_in_widget_constructors
class InterestsScreen extends StatefulWidget {
  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<Map<String, dynamic>> interests = [
    {"title": "Science & Tech", "icon": "assets/icons/science.png"},
    {"title": "Nature Exploring", "icon": "assets/icons/nature.png"},
    {"title": "Food", "icon": "assets/icons/food.png"},
    {"title": "Night Shows", "icon": "assets/icons/night.png"},
    {"title": "Hiking", "icon": "assets/icons/hiking.png"},
    {"title": "Religious Visits", "icon": "assets/icons/religion.png"},
    {"title": "Museums & Art", "icon": "assets/icons/museum.png"},
    {"title": "Nile Cruise", "icon": "assets/icons/boat.png"},
    {"title": "Shopping", "icon": "assets/icons/shopping.png"},
    {"title": "Beach", "icon": "assets/icons/beach.png"},
    {"title": "Photography", "icon": "assets/icons/photography.png"},
    {"title": "Space Exploration", "icon": "assets/icons/space.png"},
    {"title": "Diving & Beach activities", "icon": "assets/icons/diving.png"},
    {"title": "Pharaonic", "icon": "assets/icons/pharaonic.png"},
    {"title": "Road Trips", "icon": "assets/icons/raod.png"},
    {"title": "Relaxation", "icon": "assets/icons/spa.png"},
    {"title": "Nubian", "icon": "assets/icons/nubian.png"},
    {"title": "City Exploration", "icon": "assets/icons/city.png"},
    {"title": "Historical", "icon": "assets/icons/history.png"},
  ];

  Set<String> selectedInterests = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),

                  const Text(
                    "Interests",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: kprimarycolor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  const Text(
                    "In your adventure, tell us what are you looking for?",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: screenWidth * 0.02,
                        runSpacing: screenHeight * 0.005,
                        children: interests.map((interest) {
                          bool isSelected =
                              selectedInterests.contains(interest["title"]);

                          return ChoiceChip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  interest["icon"],
                                  width: 17,
                                  height: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  interest["title"],
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : kprimarycolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedInterests.add(interest["title"]);
                                } else {
                                  selectedInterests.remove(interest["title"]);
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: kprimarycolor),
                            ),
                            backgroundColor: Colors.white,
                            selectedColor: kprimarycolor,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.06,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: CustomButton(
                        text: 'Next',
                        backgroundColor: konboarding1textcolor,
                        borderColor: ksplashcolor,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}