import 'package:flutter/material.dart';
import 'package:journijots/core/utils/widgets/image_base.dart';
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
            child: Base64Image(
              base64String: imageUrls![index].imageData,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
