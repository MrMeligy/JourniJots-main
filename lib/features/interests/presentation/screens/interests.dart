import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/text_styles.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';
import 'package:journijots/features/interests/presentation/manager/cubit/customize_user_cubit.dart';
import 'package:journijots/features/interests/presentation/manager/repos/customize_user_repo_impl.dart';
import 'package:journijots/features/interests/presentation/screens/widgets/pick_profile_pic.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<Map<String, dynamic>> interests = [
    {
      "title": "Nature Exploring",
      "icon": "assets/icons/nature.png",
      "values": [
        "Nature Adventures",
        "Parks & Natural Scenery",
        "Camping Under the Stars"
      ]
    },
    {
      "title": "Food",
      "icon": "assets/icons/food.png",
      "values": ["Local Food Experiences", "Fresh Seafood Experiences"]
    },
    {
      "title": "Night Shows",
      "icon": "assets/icons/night.png",
      "values": ["Night Activities & Light Shows"]
    },
    {
      "title": "Hiking",
      "icon": "assets/icons/hiking.png",
      "values": ["Mountain Adventures & Hiking", "Road Trips & Hiking"]
    },
    {
      "title": "Religious Visits",
      "icon": "assets/icons/religion.png",
      "values": ["Historic Mosques & Churches"]
    },
    {
      "title": "Museums & Art",
      "icon": "assets/icons/museum.png",
      "values": ["Museums & Art Exhibits", "Ancient Fortresses & Castles"]
    },
    {
      "title": "Nile Cruise",
      "icon": "assets/icons/boat.png",
      "values": ["Nile Cruises & Felucca Rides", "Island Trips & Beach Escapes"]
    },
    {
      "title": "Shopping",
      "icon": "assets/icons/shopping.png",
      "values": ["Traditional Markets & Souvenirs"]
    },
    {
      "title": "Beach",
      "icon": "assets/icons/beach.png",
      "values": ["Island Trips & Beach Escapes", "Relaxation & Resorts"]
    },
    {
      "title": "Photography",
      "icon": "assets/icons/photography.png",
      "values": ["Travel Photography", "Hot Air Balloon Rides"]
    },
    {
      "title": "Space Exploration",
      "icon": "assets/icons/space.png",
      "values": ["Astronomical Observations"]
    },
    {
      "title": "Diving & Beach activities",
      "icon": "assets/icons/diving.png",
      "values": ["Scuba Diving & Snorkeling", "Island Trips & Beach Escapes"]
    },
    {
      "title": "Pharaonic",
      "icon": "assets/icons/pharaonic.png",
      "values": ["Pharaonic Temples", "Egyptian Monuments"]
    },
    {
      "title": "Road Trips",
      "icon": "assets/icons/raod.png",
      "values": ["Road Trips & Hiking", "Desert Safari"]
    },
    {
      "title": "Relaxation",
      "icon": "assets/icons/spa.png",
      "values": ["Relaxation & Resorts"]
    },
    {
      "title": "Nubian",
      "icon": "assets/icons/nubian.png",
      "values": ["Nubian Culture"]
    },
    {
      "title": "City Exploration",
      "icon": "assets/icons/city.png",
      "values": ["Cultural City Tours", "Historic Mosques & Churches"]
    },
    {
      "title": "Historical",
      "icon": "assets/icons/history.png",
      "values": [
        "Historical Tourism",
        "Ancient Fortresses & Castles",
        "Egyptian Monuments"
      ]
    },
  ];

  Set<String> selectedInterestsValues = {}; // تخزين القيم الفعلية المختارة

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomizeUserCubit(
        getIt<CustomizeUserRepoImpl>(),
      ),
      child: Scaffold(
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
                    Center(
                      child: Column(
                        children: [
                          const PickImageWidget(),
                          SizedBox(
                            height: screenHeight * 0.025,
                          ),
                          Text(
                            "Upload Profile Picture",
                            style: TextStyles.font22black,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
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
                            bool isSelected = interest["values"].any((value) =>
                                selectedInterestsValues.contains(value));
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
                                    selectedInterestsValues.addAll(
                                        List<String>.from(interest["values"]));
                                  } else {
                                    selectedInterestsValues.removeAll(
                                        List<String>.from(interest["values"]));
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
                          final customizeUserCubit =
                              context.read<CustomizeUserCubit>();
                          if (interests.isNotEmpty) {
                            customizeUserCubit
                                .addInterests(selectedInterestsValues.toList());
                          }
                          context.pushNamed(Routes.homeScreen);
                        },
                        child: BlocConsumer<CustomizeUserCubit,
                            CustomizeUserState>(
                          listener: (context, state) {
                            if (state is AddInterestsFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.errMessage),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            if (state is AddInterestsSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Add Interests Successfuly"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return (state is AddInterestsLoading)
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : CustomButton(
                                    text: 'Next',
                                    backgroundColor: konboarding1textcolor,
                                    borderColor: ksplashcolor,
                                    textColor: Colors.white,
                                  );
                          },
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
      ),
    );
  }
}
