import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/home/data/comment_model/get_comments_model/get_comments_model.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/comment_repo/comment_repo.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this.commentRepo) : super(CommentInitial());
  final CommentRepo commentRepo;
  bool _isLoaded = false;
  getComments(int postId) async {
    if (_isLoaded) return;
    emit(GetCommentsLoading());
    final response = await commentRepo.getComments(postId: postId);
    response.fold(
        (err) => emit(
              GetCommentsFailure(errMessag: err),
            ), (comments) {
      _isLoaded = true;
      emit(GetCommentsSuccess(comments: comments));
    });
  }
}
