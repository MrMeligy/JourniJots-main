import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journijots/features/interests/data/models/profile_picture_response/profile_picture_response.dart';
import 'package:journijots/features/interests/presentation/manager/repos/customize_user_repo.dart';

part 'customize_user_state.dart';

class CustomizeUserCubit extends Cubit<CustomizeUserState> {
  CustomizeUserCubit(this.customizeUserRepo) : super(CustomizeUserInitial());
  final CustomizeUserRepo customizeUserRepo;

  List<String>? interests;

  XFile? profilePic;
  uploadProfilePic(XFile image) async {
    // Set the profile pic locally first for immediate UI feedback
    profilePic = image;
    emit(ProfilePicLocallySet());

    // Start upload process
    emit(ProfilePicUploadLoading());

    // Use the repository to upload the image
    final response = await customizeUserRepo.uploadProfilePicture(image: image);

    // Handle the result
    response.fold(
      (errMessage) => emit(ProfilePicUploadFailure(errMessage: errMessage)),
      (profilePicResponse) {
        emit(ProfilePicUploadSuccess(response: profilePicResponse));
      },
    );
  }

  addInterests(List<String> interestsList) async {
    emit(AddInterestsLoading());
    interests = interestsList;
    final response = await customizeUserRepo.addIntersts(interests: interests!);
    response.fold(
      (errMessage) => AddInterestsFailure(errMessage: errMessage),
      (interestsModel) => emit(
        AddInterestsSuccess(),
      ),
    );
  }
}
