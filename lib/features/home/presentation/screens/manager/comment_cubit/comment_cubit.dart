import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:journijots/features/home/data/comment_model/get_comments_model/get_comments_model.dart';
import 'package:journijots/features/home/data/comment_model/post_comment_model.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/comment_repo/comment_repo.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this.commentRepo) : super(CommentInitial());
  TextEditingController comment = TextEditingController();

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

  postComment(int postId) async {
    emit(PostCommentsLoading());
    if (comment.text.isEmpty) {
      return emit(
        const PostCommentsFailure(errMessag: "Please enter your comment"),
      );
    }
    final response =
        await commentRepo.postComment(postId: postId, content: comment.text);
    response.fold(
        (err) => emit(
              PostCommentsFailure(errMessag: err),
            ), (comment) {
      _isLoaded = false;
      emit(
        PostCommentsSuccess(comment: comment),
      );
    });
  }
}
