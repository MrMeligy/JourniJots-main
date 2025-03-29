import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/profile/data/profile_model/profile_model.dart';
import 'package:journijots/features/profile/presentation/manager/repose/profile_repo.dart';

part 'profile_posts_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profilePostsRepo) : super(ProfileInitial());
  final ProfileRepo profilePostsRepo;

  getProfile({required String id}) async {
    emit(ProfileLoading());
    var response = await profilePostsRepo.getPosts(id: id);
    response.fold(
      (err) => emit(ProfileFailure(errMessage: err)),
      (profile) => emit(
        ProfileSuccess(profileModel: profile),
      ),
    );
  }
}
