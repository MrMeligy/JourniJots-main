import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/profile/presentation/manager/repose/profile_repo.dart';

part 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  FollowCubit(this.profileRepo) : super(FollowInitial());
  final ProfileRepo profileRepo;
  postFollow({required String userId}) async {
    emit(FollowLoading());
    final String response = await profileRepo.postFollow(userId: userId);
    if (response == "You Follow This User") {
      emit(FollowSuccess(successMessage: response));
    } else if (response == "You Don't Follow This User Now") {
      emit(UnFollowSuccess(successMessage: response));
    } else {
      emit(FollowFailure(errMessage: response));
    }
  }
}
