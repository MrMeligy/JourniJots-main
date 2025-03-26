import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/home/data/post_model/post_model.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/post_repo.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.postRepo) : super(PostInitial());
  final PostRepo postRepo;
  bool _isLoaded = false;
  getPosts() async {
    if (_isLoaded) return;
    emit(GetPostsLoading());
    final response = await postRepo.getPosts();
    response.fold((errMessage) => emit(GetPostsFailure(errMessag: errMessage)),
        (posts) {
      _isLoaded = true;
      emit(
        GetPostsSuccessfully(posts: posts),
      );
    });
  }

  toggleLike(int postId) async {
    final response = await postRepo.toggleLike(postId: postId);
    response.fold(
      (err) => emit(ToggleLikeFailure(errMessag: err)),
      (like) => emit(
        ToggleLikeSuccessfully(like: like),
      ),
    );
  }
}
