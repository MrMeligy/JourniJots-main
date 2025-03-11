import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/home/presentation/screens/widgets/image_swiper_widget.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        color: kbodycolor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/images/pp.jpg",
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Karius",
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      Text(
                        "2h ago",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "A day In Zamalek",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              RichText(
                text: TextSpan(
                    text: isLong
                        ? (isExpanded
                            ? widget.postContent
                            : "${widget.postContent.substring(0, maxlength)}...")
                        : widget.postContent,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
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
              const SizedBox(
                height: 10,
              ),
              ImageSwiper(
                imageUrls: imageUrls,
              ),
              const SizedBox(
                height: 10,
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
                      const SizedBox(
                        height: 10,
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
                            Text(
                              isLiked ? "Liked" : "Like",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Column(
                    children: [
                      Text(
                        "12 Comments",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.comment,
                            size: 30,
                            color: kprimarycolor,
                          ),
                          Text(
                            "Comment",
                            style: TextStyle(fontSize: 20),
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
