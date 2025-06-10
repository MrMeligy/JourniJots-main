import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:journijots/core/utils/widgets/image_base.dart';

class ImageHandler extends StatelessWidget {
  const ImageHandler({
    super.key,
    this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: (imageUrl == null)
          ? Image.asset(
              "assets/images/defImg.png",
              fit: BoxFit.cover,
            )
          : (imageUrl!.contains("data:image"))
              ? Base64Image(
                  base64String: imageUrl,
                )
              : CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/defImg.png"),
                ),
    );
  }
}
