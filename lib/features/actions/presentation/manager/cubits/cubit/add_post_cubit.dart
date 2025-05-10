import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/actions/presentation/manager/repos/create_post_repo.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this.createPostRepo) : super(AddPostInitial());
  final CreatePostRepo createPostRepo;
  addPost({required String post, List<String>? imagePaths}) async {
    int? postId;
    emit(AddPostLoading());
    var createPostModel = await createPostRepo.addPost(
      post: post,
      category: "Pharaonic Temples",
      imagePaths: imagePaths,
    );
    createPostModel.fold(
        (err) => emit(
              AddPostFailure(err: err),
            ), (post) {
      postId = post.postId;
      return emit(
        AddPostSuccess(),
      );
    });
    if (postId != null) {
      String category = await createPostRepo.classifyPost(post: post);
      createPostRepo.updatePost(postId: postId!, category: category);
    }
  }
}
