import 'package:dartz/dartz.dart';
import 'package:journijots/features/auth/data/auth_model/auth_model.dart';

abstract class UserRepo {
  Future<Either<String, AuthModel>> logIn({
    required String logInEmail,
    required String logInPassword,
  });
  Future<Either<String, AuthModel>> signUp({
    required String signUpFirstName,
    required String signUpLastName,
    required String signUpUserName,
    required String signUpEmail,
    required String signUpPassword,
    required String city,
  });
}
