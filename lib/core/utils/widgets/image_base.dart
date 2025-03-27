import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class Base64Image extends StatelessWidget {
  final String? base64String;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const Base64Image({
    super.key,
    this.base64String,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    // Remove data URI prefix if present
    if (base64String == null) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey,
        child: Image.asset("assets/images/avatar.png"),
      );
    }

    String data = base64String!;
    if (data.contains(',')) {
      data = data.split(',')[1];
    }

    try {
      Uint8List bytes = base64.decode(data);

      return Image.memory(
        bytes,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey,
            child: const Icon(Icons.error),
          );
        },
      );
    } catch (e) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey,
        child: Image.asset("assets/images/avatar.png"),
      );
    }
  }
}
