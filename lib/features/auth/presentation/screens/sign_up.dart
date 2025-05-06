// ignore_for_file: unused_import

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/cache/cache_helper.dart';
// ignore: duplicate_ignore
// ignore: unused_import
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';
import 'package:journijots/features/auth/presentation/manager/user_cubit/user_cubit.dart';
import 'package:journijots/features/auth/presentation/screens/widgets/custom_textfeild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Map<String, bool> _fieldErrors = {
    'firstName': false,
    'lastName': false,
    'userName': false,
    'email': false,
    'password': false,
    'confirmPassword': false,
  };

  final Map<String, String> _errorMessages = {
    'firstName': 'First name is required',
    'lastName': 'Last name is required',
    'userName': 'Username is required',
    'email': 'Valid email is required',
    'password': 'Password must be at least 8 characters',
    'confirmPassword': 'Passwords do not match',
  };

  void _validateFields() {
    final userCubit = context.read<UserCubit>();

    setState(() {
      // Reset all errors first
      _fieldErrors.updateAll((key, value) => false);

      // Validate First Name
      if (userCubit.signUpFirstName.text.isEmpty) {
        _fieldErrors['firstName'] = true;
      }

      // Validate Last Name
      if (userCubit.signUpLastName.text.isEmpty) {
        _fieldErrors['lastName'] = true;
      }

      // Validate Username
      if (userCubit.signUpUserName.text.isEmpty) {
        _fieldErrors['userName'] = true;
      }

      // Validate Email with Regex
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (userCubit.signUpEmail.text.isEmpty ||
          !emailRegex.hasMatch(userCubit.signUpEmail.text)) {
        _fieldErrors['email'] = true;
        if (userCubit.signUpEmail.text.isNotEmpty) {
          _errorMessages['email'] = 'Please enter a valid email address';
        }
      }

      // Validate Password
      if (userCubit.signUpPassword.text.isEmpty ||
          userCubit.signUpPassword.text.length < 8) {
        _fieldErrors['password'] = true;
      }

      // Validate Confirm Password
      if (userCubit.confirmPassword.text.isEmpty ||
          userCubit.confirmPassword.text != userCubit.signUpPassword.text) {
        _fieldErrors['confirmPassword'] = true;
        if (userCubit.confirmPassword.text.isNotEmpty) {
          _errorMessages['confirmPassword'] = 'Passwords do not match';
        }
      }
    });

    // Check if all fields are valid
    final bool hasErrors = _fieldErrors.values.any((isError) => isError);

    if (!hasErrors) {
      context.read<UserCubit>().signUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign Up Success'),
            ),
          );
          getIt<CacheHelper>().saveData(key: "LoggedIn", value: true);
          context.pushNamed(Routes.interestsScreen);
        }
        if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessag),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: konboarding1textcolor,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: context.read<UserCubit>().signUpFormKey,
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.04),

                    // App Logo (Title)
                    const Text(
                      "JourniJots",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Serif",
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Background Image (Responsive)
                    Image.asset(
                      'assets/images/Layer_1.png',
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.2,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // White Curved Container
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.03,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kprimarycolor,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          const Text(
                            "First Name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.001),
                          CustomTextField(
                            label: 'First Name',
                            icon: Icons.person,
                            controller:
                                context.read<UserCubit>().signUpFirstName,
                            showError: _fieldErrors['firstName'] ?? false,
                            errorText: _errorMessages['firstName'],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          const Text(
                            "Last Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight * 0.001),
                          CustomTextField(
                            label: 'Last Name',
                            icon: Icons.person,
                            controller:
                                context.read<UserCubit>().signUpLastName,
                            showError: _fieldErrors['lastName'] ?? false,
                            errorText: _errorMessages['lastName'],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          const Text(
                            "User Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight * 0.001),
                          CustomTextField(
                            label: 'Username',
                            icon: Icons.person_outline,
                            controller:
                                context.read<UserCubit>().signUpUserName,
                            showError: _fieldErrors['userName'] ?? false,
                            errorText: _errorMessages['userName'],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight * 0.001),
                          CustomTextField(
                            label: 'Email',
                            icon: Icons.email,
                            controller: context.read<UserCubit>().signUpEmail,
                            showError: _fieldErrors['email'] ?? false,
                            errorText: _errorMessages['email'],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          const Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight * 0.001),
                          CustomTextField(
                            label: 'Password',
                            icon: Icons.lock,
                            isPassword: true,
                            controller:
                                context.read<UserCubit>().signUpPassword,
                            showError: _fieldErrors['password'] ?? false,
                            errorText: _errorMessages['password'],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          const Text(
                            "Confirm Password",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight * 0.001),
                          CustomTextField(
                            label: 'Confirm Password',
                            icon: Icons.lock,
                            isPassword: true,
                            controller:
                                context.read<UserCubit>().confirmPassword,
                            showError: _fieldErrors['confirmPassword'] ?? false,
                            errorText: _errorMessages['confirmPassword'],
                          ),
                          const Text(
                            "Your City Or Your Destination",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight * 0.001),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: DropDownTextField(
                              initialValue: "Cairo",
                              clearOption: false,
                              textFieldDecoration: const InputDecoration(
                                hintText: "Select City",
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: Colors.blue,
                                ),
                              ),
                              onChanged: (value) {
                                if (value is DropDownValueModel) {
                                  context.read<UserCubit>().city.text =
                                      value.value;
                                }
                              },
                              dropDownList: const [
                                DropDownValueModel(
                                    name: "Cairo", value: "Cairo"),
                                DropDownValueModel(name: "Giza", value: "Giza"),
                                DropDownValueModel(
                                    name: "Alexandria", value: "Alexandria"),
                                DropDownValueModel(
                                    name: "Dahab", value: "Dahab"),
                                DropDownValueModel(name: "Taba", value: "Taba"),
                                DropDownValueModel(
                                    name: "Luxor", value: "Luxor"),
                                DropDownValueModel(
                                    name: "Aswan", value: "Aswan"),
                                DropDownValueModel(
                                    name: "Sharm Elsheikh",
                                    value: "Sharm Elsheikh"),
                                DropDownValueModel(
                                    name: "Hurghada", value: "Hurghada"),
                                DropDownValueModel(
                                    name: "Alamein", value: "Alamein"),
                                DropDownValueModel(
                                    name: "Port Said", value: "Port Said"),
                                DropDownValueModel(name: "Suez", value: "Suez"),
                                DropDownValueModel(
                                    name: "Marsa Alam", value: "Marsa Alam"),
                                DropDownValueModel(
                                    name: "Fayoum", value: "Fayoum"),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/logIn');
                              },
                              child: const Text(
                                "Already have an account? Login",
                                style: TextStyle(
                                    color: ksplashcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: screenWidth * 0.5,
                              height: 1,
                              color: ksplashcolor,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight * 0.06,
                            child: GestureDetector(
                              onTap: () {
                                _validateFields();
                              },
                              child: state is SignUpLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        _validateFields();
                                      },
                                      child: CustomButton(
                                        text: 'Sign up',
                                        backgroundColor: konboarding1textcolor,
                                        borderColor: konboardingbuttun,
                                        textColor: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
