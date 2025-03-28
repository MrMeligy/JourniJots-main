import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/home/data/post_model/paginaton_post_model/post.dart';
// import 'package:journijots/features/home/data/post_model/post_model.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/post_repo/post_repo.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.postRepo) : super(PostInitial());

  final PostRepo postRepo;
  List<Post> _allPosts = [];

  getPosts(int pageNumber, {bool loadMore = false}) async {
    // If it's the first page and not loading more, reset the posts
    if (pageNumber == 1 && !loadMore) {
      _allPosts.clear();
    }

    emit(GetPostsLoading());

    final response = await postRepo.getPosts();

    response.fold(
      (errMessage) => emit(GetPostsFailure(errMessag: errMessage)),
      (posts) {
        // If loading more, append to existing posts
        if (loadMore) {
          _allPosts.addAll(posts);
        } else {
          // Otherwise, replace existing posts
          _allPosts = posts;
        }

        emit(GetPostsSuccessfully(posts: _allPosts));
      },
    );
  }

  toggleLike(int postId) async {
    final response = await postRepo.toggleLike(postId: postId);

    response.fold(
      (err) => emit(ToggleLikeFailure(errMessag: err)),
      (like) => emit(ToggleLikeSuccessfully(like: like)),
    );
  }
}
