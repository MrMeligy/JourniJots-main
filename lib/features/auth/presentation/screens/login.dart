import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';
import 'package:journijots/features/auth/presentation/manager/user_cubit/user_cubit.dart';
import 'package:journijots/features/auth/presentation/screens/widgets/custom_textfeild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Map<String, bool> _fieldErrors = {
    'email': false,
    'password': false,
  };

  final Map<String, String> _errorMessages = {
    'email': 'Email is required',
    'password': 'Password is required',
  };

  void _validateFields() {
    final userCubit = context.read<UserCubit>();

    setState(() {
      // Reset all errors first
      _fieldErrors.updateAll((key, value) => false);

      // Validate Email with Regex
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (userCubit.logInEmail.text.isEmpty) {
        _fieldErrors['email'] = true;
      } else if (!emailRegex.hasMatch(userCubit.logInEmail.text)) {
        _fieldErrors['email'] = true;
        _errorMessages['email'] = 'Please enter a valid email address';
      }

      // Validate Password
      if (userCubit.logInPassword.text.isEmpty) {
        _fieldErrors['password'] = true;
      } else if (userCubit.logInPassword.text.length < 8) {
        _fieldErrors['password'] = true;
        _errorMessages['password'] = 'Password must be at least 8 characters';
      }
    });

    // Check if all fields are valid
    final bool hasErrors = _fieldErrors.values.any((isError) => isError);

    if (!hasErrors) {
      context.read<UserCubit>().logIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is LogInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Success'),
            ),
          );
          getIt<CacheHelper>().saveData(key: "LoggedIn", value: true);
          context.pushNamed(Routes.homeScreen);
        } else if (state is LogInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessag),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: konboarding1textcolor,
          body: Form(
            key: context.read<UserCubit>().logInFormKey,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.07),

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
                SizedBox(height: screenHeight * 0.03),

                // Background Image (Responsive)
                Image.asset(
                  'assets/images/Group.png',
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.25,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: screenHeight * 0.03),

                // White Curved Container that takes the remaining space
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenWidth * 0.06),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Login Title
                          const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: kprimarycolor,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          // Email Label
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight * 0.001),

                          // Email Text Field with Icon
                          CustomTextField(
                            label: 'Email',
                            icon: Icons.email,
                            controller: context.read<UserCubit>().logInEmail,
                            showError: _fieldErrors['email'] ?? false,
                            errorText: _errorMessages['email'],
                          ),

                          SizedBox(height: screenHeight * 0.01),

                          // Password Label
                          const Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight * 0.001),

                          // Password Text Field with Icon
                          CustomTextField(
                            label: 'Password',
                            icon: Icons.lock,
                            isPassword: true,
                            controller: context.read<UserCubit>().logInPassword,
                            showError: _fieldErrors['password'] ?? false,
                            errorText: _errorMessages['password'],
                          ),

                          SizedBox(height: screenHeight * 0.02),

                          // Sign Up & Forgot Password with Underline
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/SignUp');
                                    },
                                    child: const Text(
                                      "Don't have an account? Sign up",
                                      style: TextStyle(
                                          color: ksplashcolor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.47,
                                    height: 1,
                                    color: ksplashcolor,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to Forgot Password
                                    },
                                    child: const Text(
                                      "Forgot password?",
                                      style: TextStyle(
                                          color: ksplashcolor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.27,
                                    height: 1,
                                    color: ksplashcolor,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: screenHeight * 0.03),

                          // Login Button
                          (state is LogInLoading)
                              ? const Center(child: CircularProgressIndicator())
                              : SizedBox(
                                  width: double.infinity,
                                  height: screenHeight * 0.06,
                                  child: GestureDetector(
                                    onTap: () {
                                      _validateFields();
                                    },
                                    child: CustomButton(
                                      text: 'Log in',
                                      backgroundColor: konboarding1textcolor,
                                      borderColor: konboardingbuttun,
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
