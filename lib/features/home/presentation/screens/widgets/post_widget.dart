import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/text_styles.dart';
import 'package:journijots/features/home/data/post_model/paginaton_post_model/post.dart';
// import 'package:journijots/features/home/data/post_model/post_model.dart';
import 'package:journijots/features/home/presentation/screens/manager/comment_cubit/comment_cubit.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/comment_repo/comment_repo_impl.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/post_repo/post_repo_impl.dart';
import 'package:journijots/features/home/presentation/screens/widgets/draggable_comment_sheet.dart';
import 'package:journijots/features/home/presentation/screens/widgets/image_swiper_widget.dart';
import 'package:journijots/features/home/presentation/screens/widgets/post_profile.dart';

class PostWidget extends StatefulWidget {
  final Post? post;

  const PostWidget({super.key, this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isExpanded = false;
  bool? isLiked;
  int? likesCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post?.isLikedByCurrentUser;
    likesCount = widget.post?.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    // إذا كان الـ post null، أظهر skeleton
    if (widget.post == null) {
      return _buildSkeletonPost();
    }

    int maxlength = 180;
    bool isLong = widget.post!.post.length > maxlength;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Card(
        color: kbodycolor,
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PostProfile(
                postModel: widget.post!,
              ),
              SizedBox(
                height: 16.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: isLong
                          ? (isExpanded
                              ? widget.post!.post
                              : "${widget.post!.post.substring(0, maxlength)}...")
                          : widget.post!.post,
                      style: TextStyles.font18Black,
                      children: isLong
                          ? [
                              TextSpan(
                                text: isExpanded ? " See less" : " See more",
                                style: const TextStyle(
                                  color: kprimarycolor,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                              ),
                            ]
                          : [],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              widget.post!.postImages!.isNotEmpty
                  ? ImageSwiper(imageUrls: widget.post!.postImages)
                  : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //like
                  Column(
                    children: [
                      Text(
                        "$likesCount Likes",
                        style: const TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getIt<PostRepoImpl>()
                                .toggleLike(postId: widget.post!.postId);
                            isLiked!
                                ? likesCount = likesCount! - 1
                                : likesCount = likesCount! + 1;
                            isLiked = !isLiked!;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              isLiked!
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: kprimarycolor,
                              size: 30,
                            ),
                            Text(isLiked! ? "Liked" : "Like",
                                style: TextStyles.font20BlueBold)
                          ],
                        ),
                      )
                    ],
                  ),

                  //comment
                  Column(
                    children: [
                      Text(
                        "${widget.post!.commentCount} Comments",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            useSafeArea: true,
                            context: context,
                            builder: (BuildContext bottomSheetContext) {
                              return BlocProvider(
                                create: (context) =>
                                    CommentCubit(getIt<CommentRepoImpl>()),
                                child: DraggableCommentSheet(
                                  postId: widget.post!.postId,
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.comment,
                              size: 30,
                              color: kprimarycolor,
                            ),
                            Text(
                              "Comment",
                              style: TextStyles.font20BlueBold,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // skeleton widget
  Widget _buildSkeletonPost() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Card(
        color: kbodycolor,
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile skeleton
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.w,
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100.w,
                        height: 15.h,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        width: 80.w,
                        height: 10.h,
                        color: Colors.grey[300],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 16.h),

              // Post text skeleton
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 15.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: double.infinity,
                    height: 15.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: 200.w,
                    height: 15.h,
                    color: Colors.grey[300],
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Bottom row skeleton
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 80.w,
                        height: 15.h,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            color: Colors.grey[300],
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            width: 50.w,
                            height: 15.h,
                            color: Colors.grey[300],
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 80.w,
                        height: 15.h,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            color: Colors.grey[300],
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            width: 50.w,
                            height: 15.h,
                            color: Colors.grey[300],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
