import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/features/auth/data/models/login_response_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;
  //Sign in Form key
  GlobalKey<FormState> logInFormKey = GlobalKey();
  //Sign in email
  TextEditingController logInEmail = TextEditingController();
  //Sign in password
  TextEditingController logInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  //XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  LoginResponseModel? user;
  logIn() async {
    try {
      emit(LogInLoading());
      final response = await api.post(EndPoint.logIn, data: {
        ApiKey.email: logInEmail.text,
        ApiKey.password: logInPassword.text,
      });
      user = LoginResponseModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user!.token);
      CacheHelper().saveData(key: ApiKey.token, value: user!.token);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      emit(LogInSuccess());
    } catch (e) {
      emit(LogInFailure(errMessag: e.toString()));
    }
  }
}
