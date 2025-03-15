import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/text_styles.dart';
import 'package:journijots/features/home/presentation/screens/widgets/image_swiper_widget.dart';
import 'package:journijots/features/home/presentation/screens/widgets/post_profile.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key, required this.postContent});
  final String postContent;
  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isExpanded = false;
  bool isLiked = false;
  final List<String> imageUrls = [
    "assets/images/z1.webp",
    "assets/images/z2.jpg",
    "assets/images/z3.jpg",
    //"assets/images/z4.jpg",
    //"assets/images/z5.jpg",
    //"assets/images/z6.jpg",
    //"assets/images/z7.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    int maxlength = 180; //max words in posts to show
    bool isLong =
        widget.postContent.length > maxlength; //if it long will show see more

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
              const PostProfile(),
              SizedBox(
                height: 16.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "A day In Zamalek",
                    style: TextStyles.font18BlackBold,
                  ),
                  RichText(
                    text: TextSpan(
                        text: isLong
                            ? (isExpanded
                                ? widget.postContent
                                : "${widget.postContent.substring(0, maxlength)}...")
                            : widget.postContent,
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
                            : []),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              ImageSwiper(
                imageUrls: imageUrls,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "23 Likes",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              isLiked ? Icons.favorite : Icons.favorite_outline,
                              color: kprimarycolor,
                              size: 30,
                            ),
                            Text(isLiked ? "Liked" : "Like",
                                style: TextStyles.font20BlueBold)
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "12 Comments",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
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
