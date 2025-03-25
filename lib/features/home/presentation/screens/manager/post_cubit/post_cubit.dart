import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/home/data/post_model/post_model.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/post_repo.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.postRepo) : super(PostInitial());
  final PostRepo postRepo;
  getPosts() async {
    emit(GetPostsLoading());
    final response = await postRepo.getPosts();
    response.fold(
        (errMessage) => emit(
              GetPostsFailure(errMessag: errMessage),
            ),
        (posts) => emit(
              GetPostsSuccessfully(posts: posts),
            ));
  }
}
