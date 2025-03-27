import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/features/home/presentation/screens/manager/comment_cubit/comment_cubit.dart';
import 'package:journijots/features/home/presentation/screens/widgets/comments_bottom_sheet.dart';

class DraggableCommentSheet extends StatelessWidget {
  const DraggableCommentSheet({
    super.key,
    required this.postId,
  });
  final int postId;
  @override
  Widget build(BuildContext context) {
    context.read<CommentCubit>().getComments(postId);
    return DraggableScrollableSheet(
      initialChildSize: 0.99,
      maxChildSize: 0.99,
      builder: (context, scrollController) {
        return CommentBottomSheet(
          scrollController: scrollController,
          postId: postId,
        );
      },
    );
  }
}
