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
                          context.pushNamed(Routes.mainScreen);
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
