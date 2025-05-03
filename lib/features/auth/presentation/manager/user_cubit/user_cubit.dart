import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:journijots/features/auth/data/auth_model/auth_model.dart';
import 'package:journijots/features/auth/presentation/manager/repos/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo) : super(UserInitial());
  //Sign in Form key
  GlobalKey<FormState> logInFormKey = GlobalKey();
  //Sign in email
  TextEditingController logInEmail = TextEditingController();
  //Sign in password
  TextEditingController logInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  // XFile? profilePic;
  //Sign up name
  TextEditingController signUpFirstName = TextEditingController();
  TextEditingController signUpLastName = TextEditingController();
  TextEditingController signUpUserName = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController city = TextEditingController();
  AuthModel? user;

  final UserRepo userRepo;
  logIn() async {
    emit(LogInLoading());

    final response = await userRepo.logIn(
      logInEmail: logInEmail.text,
      logInPassword: logInPassword.text,
    );
    response.fold(
      (errMessage) => emit(LogInFailure(errMessag: errMessage)),
      (user) => emit(LogInSuccess()),
    );
    // try {
    //   emit(LogInLoading());
    //   final response = await api.post(EndPoint.logIn, data: {
    //     ApiKey.email: logInEmail.text,
    //     ApiKey.password: logInPassword.text,
    //   });

    //   user = AuthModel.fromJson(response);
    //   final decodedToken = JwtDecoder.decode(user!.token!);
    //   getIt<CacheHelper>().saveData(key: ApiKey.token, value: user!.token);
    //   getIt<CacheHelper>()
    //       .saveData(key: ApiKey.id, value: decodedToken[ApiKey.tokenId]);
    //   emit(LogInSuccess());
    // } on ServerException catch (e) {
    //   emit(LogInFailure(errMessag: e.errModel.errorMessage));
    // }
  }

  signUp() async {
    emit(SignUpLoading());

    final response = await userRepo.signUp(
      signUpFirstName: signUpFirstName.text,
      signUpLastName: signUpLastName.text,
      signUpUserName: signUpUserName.text,
      signUpEmail: signUpEmail.text,
      signUpPassword: signUpPassword.text,
      city: city.text,
    );
    response.fold(
      (errMessage) => emit(
        SignUpFailure(errMessag: errMessage),
      ),
      (user) => emit(
        SignUpSuccess(),
      ),
    );
    // try {
    //   emit(SignUpLoading());
    //   final response = await api.post(EndPoint.register, data: {
    //     ApiKey.firstName: signUpFirstName.text,
    //     ApiKey.lastName: signUpLastName.text,
    //     ApiKey.userName: signUpUserName.text,
    //     ApiKey.email: signUpEmail.text,
    //     ApiKey.password: signUpPassword.text,
    //   });

    //   user = AuthModel.fromJson(response);
    //   final decodedToken = JwtDecoder.decode(user!.token!);
    //   getIt<CacheHelper>().saveData(
    //     key: ApiKey.token,
    //     value: user!.token,
    //   );
    //   getIt<CacheHelper>().saveData(
    //     key: ApiKey.id,
    //     value: decodedToken[ApiKey.tokenId],
    //   );
    //   emit(SignUpSuccess());
    // } on ServerException catch (e) {
    //   emit(SignUpFailure(errMessag: e.errModel.errorMessage));
    // }
  }

  // uploadProfilePic(XFile image) async {
  //   // Set the profile pic locally first for immediate UI feedback
  //   profilePic = image;
  //   emit(ProfilePicLocallySet());

  //   // Start upload process
  //   emit(ProfilePicUploadLoading());

  //   // Use the repository to upload the image
  //   final response = await userRepo.uploadProfilePicture(image: image);

  //   // Handle the result
  //   response.fold(
  //     (errMessage) => emit(ProfilePicUploadFailure(errMessage: errMessage)),
  //     (profilePicResponse) {
  //       emit(ProfilePicUploadSuccess(response: profilePicResponse));
  //     },
  //   );
  // }
}
