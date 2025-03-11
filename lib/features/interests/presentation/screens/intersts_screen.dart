import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';
import 'package:journijots/features/interests/presentation/screens/widgets/interest_container.dart';

class InterstsScreen extends StatefulWidget {
  const InterstsScreen({super.key});

  @override
  State<InterstsScreen> createState() => _InterstsScreenState();
}

class _InterstsScreenState extends State<InterstsScreen> {
  final List<String> _interests = const [
    "Egyptian Monuments",
    "Desert Safari",
    "Scuba Diving & Snorkeling",
    "Nature Adventures",
    "Nile Cruises & Felucca Rides",
    "Museums & Art Exhibits",
    "Traditional Markets & Souvenirs",
    "Local Food Experiences",
    "Pharaonic Temples",
    "Travel Photography",
    "Hot Air Balloon Rides",
    "Nubian Culture",
    "Island Trips & Beach Escapes",
    "Relaxation & Resorts",
    "Camping Under the Stars",
    "Mountain Adventures & Hiking",
    "Parks & Natural Scenery",
    "Ancient Fortresses & Castles",
    "Historic Mosques & Churches",
    "Fresh Seafood Experiences",
    "Cultural City Tours",
    "Night Activities & Light Shows",
    "Road Trips & Hiking",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbodycolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 14),
              const Center(
                child: Text(
                  "Interests",
                  style: TextStyle(fontSize: 50, color: Color(0xff8CB6DC)),
                ),
              ),
              const Text(
                "in your adventure, tell us what are you looking for?",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 1240,
                    child: Stack(children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[0],
                        ),
                      ),
                      Positioned(
                        top: 55,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[1],
                        ),
                      ),
                      Positioned(
                        top: 110,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[2],
                        ),
                      ),
                      Positioned(
                        top: 55,
                        left: 140,
                        child: InterestContainer(
                          title: _interests[3],
                        ),
                      ),
                      Positioned(
                        top: 165,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[4],
                        ),
                      ),
                      Positioned(
                        top: 220,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[5],
                        ),
                      ),
                      Positioned(
                        top: 275,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[6],
                        ),
                      ),
                      Positioned(
                        top: 330,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[7],
                        ),
                      ),
                      Positioned(
                        top: 385,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[8],
                        ),
                      ),
                      Positioned(
                        top: 440,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[9],
                        ),
                      ),
                      Positioned(
                        top: 495,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[10],
                        ),
                      ),
                      Positioned(
                        top: 550,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[11],
                        ),
                      ),
                      // إضافة باقي العناصر
                      Positioned(
                        top: 605,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[12],
                        ),
                      ),
                      Positioned(
                        top: 660,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[13],
                        ),
                      ),
                      Positioned(
                        top: 715,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[14],
                        ),
                      ),
                      Positioned(
                        top: 770,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[15],
                        ),
                      ),
                      Positioned(
                        top: 825,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[16],
                        ),
                      ),
                      Positioned(
                        top: 880,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[17],
                        ),
                      ),
                      Positioned(
                        top: 935,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[18],
                        ),
                      ),
                      Positioned(
                        top: 990,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[19],
                        ),
                      ),
                      Positioned(
                        top: 1045,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[20],
                        ),
                      ),
                      Positioned(
                        top: 1100,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[21],
                        ),
                      ),
                      Positioned(
                        top: 1155,
                        left: 0,
                        child: InterestContainer(
                          title: _interests[22],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'mainscreen');
                },
                child: CustomButton(
                  text: 'Next',
                  backgroundColor: const Color(0xff8CB6DC),
                  borderColor: const Color(0xff8CB6DC),
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
