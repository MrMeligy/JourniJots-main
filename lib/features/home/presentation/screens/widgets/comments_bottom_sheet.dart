import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/auth/presentation/screens/widgets/custom_textfeild.dart';
import 'package:journijots/features/home/presentation/screens/manager/comment_cubit/comment_cubit.dart';
import 'package:journijots/features/home/presentation/screens/widgets/profile_picture.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CommentBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const CommentBottomSheet({
    super.key,
    required this.scrollController,
    required this.postId,
  });
  final int postId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state is PostCommentsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessag),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is PostCommentsSuccess) {
          context.read<CommentCubit>().getComments(postId);
        }
      },
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: (state is GetCommentsLoading)
              ? const CommentsSkeletonizer()
              : Column(
                  children: [
                    Text(
                      'Comments',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: kprimarycolor),
                    ),
                    if (state is GetCommentsSuccess)
                      state.comments.isEmpty
                          ? Expanded(
                              child: Center(
                                child: Text(
                                  'No Comments Yet',
                                  style: TextStyle(
                                      fontSize: 16.sp, color: kprimarycolor),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                shrinkWrap: true,
                                itemCount: state.comments.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 8.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ProfilePicture(
                                          picture: state
                                              .comments[index].profilePicture,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.comments[index].userName,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              BubbleSpecialOne(
                                                text: state
                                                    .comments[index].content,
                                                isSender: false,
                                                color: kprimarycolor,
                                                textStyle: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    //Add Comment Field
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: CustomTextField(
                        label: "Add Comment",
                        icon: Icons.comment,
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (context
                                .read<CommentCubit>()
                                .comment
                                .text
                                .isEmpty) {
                              return;
                            }
                            context.read<CommentCubit>().postComment(postId);
                            context.read<CommentCubit>().comment.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                        ),
                        controller: context.read<CommentCubit>().comment,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
        );
      },
    );
  }
}

class CommentsSkeletonizer extends StatelessWidget {
  const CommentsSkeletonizer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      ignoreContainers: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfilePicture(),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UserName',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      BubbleSpecialOne(
                        text: 'Comment Comment Comment',
                        isSender: false,
                        color: kprimarycolor,
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
