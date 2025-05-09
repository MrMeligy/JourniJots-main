import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:journijots/features/home/data/post_model/post_image.dart';

class ImageSwiper extends StatelessWidget {
  const ImageSwiper({super.key, this.imageUrls});
  final List<PostImage>? imageUrls;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: imageUrls!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imageUrls![index].imageData!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
