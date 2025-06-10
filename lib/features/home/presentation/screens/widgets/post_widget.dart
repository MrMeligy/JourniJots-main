import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/home/data/post_model/paginaton_post_model/post.dart';
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

class _PostWidgetState extends State<PostWidget> with TickerProviderStateMixin {
  bool isExpanded = false;
  bool? isLiked;
  int? likesCount;
  late AnimationController _likeAnimationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _likeAnimation;
  late Animation<double> _cardAnimation;
  late Animation<Color?> _cardColorAnimation;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post?.isLikedByCurrentUser;
    likesCount = widget.post?.likeCount;

    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _likeAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
          parent: _likeAnimationController, curve: Curves.elasticOut),
    );

    _cardAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _cardAnimationController, curve: Curves.easeOutBack),
    );

    _cardColorAnimation = ColorTween(
      begin: Colors.white,
      end: kbodycolor,
    ).animate(_cardAnimationController);

    _cardAnimationController.forward();
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.post == null) {
      return _buildSkeletonPost();
    }

    int maxlength = 180;
    bool isLong = widget.post!.post.length > maxlength;

    return AnimatedBuilder(
      animation: _cardAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _cardAnimation.value.clamp(0.0, 1.0), // Clamp scale value
          child: Opacity(
            opacity:
                _cardAnimation.value.clamp(0.0, 1.0), // Clamp opacity value
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: _cardColorAnimation.value,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize
                      .min, // Added to prevent unnecessary expansion
                  children: [
                    // Header with gradient background
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            kprimarycolor.withOpacity(0.05),
                            Colors.transparent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: EdgeInsets.all(16.w),
                      child: PostProfile(
                        postModel: widget.post!,
                      ),
                    ),

                    // Post content
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize
                            .min, // Added to prevent unnecessary expansion
                        children: [
                          // Post text with better typography
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: RichText(
                              text: TextSpan(
                                text: isLong
                                    ? (isExpanded
                                        ? widget.post!.post
                                        : "${widget.post!.post.substring(0, maxlength)}...")
                                    : widget.post!.post,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16.sp,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: isLong
                                    ? [
                                        TextSpan(
                                          text: isExpanded
                                              ? " Show less"
                                              : " Show more",
                                          style: TextStyle(
                                            color: kprimarycolor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.sp,
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
                          ),

                          SizedBox(height: 12.h),

                          // Images with rounded corners and constrained height
                          if (widget.post!.postImages!.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(bottom: 16.h),
                              constraints: BoxConstraints(
                                maxHeight: 400.h, // Constrain image height
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: ImageSwiper(
                                    imageUrls: widget.post!.postImages),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Divider
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            const Color.fromARGB(255, 44, 141, 180)
                                .withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    // Action buttons with improved design
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        children: [
                          // Like section
                          Expanded(
                            child: _buildActionButton(
                              icon: AnimatedBuilder(
                                animation: _likeAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _likeAnimation.value,
                                    child: Icon(
                                      isLiked!
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color: isLiked!
                                          ? const Color.fromARGB(
                                              255, 51, 126, 192)
                                          : Colors.grey[600],
                                      size: 24.w,
                                    ),
                                  );
                                },
                              ),
                              label: isLiked! ? "Liked" : "Like",
                              count: "$likesCount",
                              isActive: isLiked!,
                              onTap: _handleLike,
                            ),
                          ),

                          SizedBox(width: 16.w),

                          // Comment section
                          Expanded(
                            child: _buildActionButton(
                              icon: Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: const Color.fromARGB(255, 40, 113, 155),
                                size: 24.w,
                              ),
                              label: "Comment",
                              count: "${widget.post!.commentCount}",
                              isActive: false,
                              onTap: _handleComment,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required Widget icon,
    required String label,
    required String count,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isActive ? kprimarycolor.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: isActive
                ? kprimarycolor.withOpacity(0.3)
                : Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 8.w),
            Flexible(
              // Added to prevent overflow
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: isActive ? kprimarycolor : Colors.grey[700],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                  Text(
                    count,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLike() {
    setState(() {
      getIt<PostRepoImpl>().toggleLike(postId: widget.post!.postId);
      isLiked! ? likesCount = likesCount! - 1 : likesCount = likesCount! + 1;
      isLiked = !isLiked!;
    });

    _likeAnimationController.forward().then((_) {
      _likeAnimationController.reverse();
    });
  }

  void _handleComment() {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(0, 147, 146, 146),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bottomSheetContext) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: BlocProvider(
            create: (context) => CommentCubit(getIt<CommentRepoImpl>()),
            child: DraggableCommentSheet(
              postId: widget.post!.postId,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonPost() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize:
              MainAxisSize.min, // Added to prevent unnecessary expansion
          children: [
            // Profile skeleton with shimmer effect
            Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  // Added to prevent overflow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 44, 117, 162),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        width: 80.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 44, 117, 162),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // Post content skeleton
            ...List.generate(
                3,
                (index) => Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      width: index == 2 ? 200.w : double.infinity,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 72, 109, 161),
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                    )),

            SizedBox(height: 24.h),

            // Action buttons skeleton
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 44, 117, 162),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 44, 117, 162),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
