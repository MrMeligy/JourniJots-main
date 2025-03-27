import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/auth/presentation/screens/widgets/custom_textfeild.dart';
import 'package:journijots/features/home/presentation/screens/manager/comment_cubit/comment_cubit.dart';
import 'package:journijots/features/home/presentation/screens/widgets/profile_picture.dart';

class CommentBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const CommentBottomSheet({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: (state is GetCommentsLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
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
                      child: const CustomTextField(
                        label: "Add Comment",
                        icon: Icons.comment,
                        suffixIcon: Icons.send,
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
