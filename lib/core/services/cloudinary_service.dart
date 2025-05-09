// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:path/path.dart';

class CloudinaryService {
  final Dio dio;
  final String? profilePic;
  final List<String>? postPics;

  static const String cloudName = "dx3ttxggc";
  static const String uploadPreset = "journijots";
  static const String apiKey = "737995691132891";

  CloudinaryService({
    required this.dio,
    this.profilePic,
    this.postPics,
  });

  Future<String?> uploadProfilePic() async {
    if (profilePic == null) return null;

    try {
      final file = await MultipartFile.fromFile(profilePic!,
          filename: basename(profilePic!));

      final formData = FormData.fromMap({
        'file': file,
        'upload_preset': uploadPreset,
        'api_key': apiKey,
        'public_id': basename(profilePic!).split(".").first,
      });

      final response = await dio.post(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
        data: formData,
      );

      return response.data['secure_url']; // URL الخاص بالصورة
    } catch (e) {
      print("Error uploading profile pic: $e");
      return null;
    }
  }

  Future<List<String>> uploadPostPics() async {
    if (postPics == null || postPics!.isEmpty) return [];

    List<String> urls = [];

    for (String path in postPics!) {
      try {
        final file =
            await MultipartFile.fromFile(path, filename: basename(path));

        final formData = FormData.fromMap({
          'file': file,
          'upload_preset': uploadPreset,
          'api_key': apiKey,
          'public_id': basename(path).split(".").first,
        });

        final response = await dio.post(
          'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
          data: formData,
        );

        urls.add(response.data['secure_url']);
      } catch (e) {
        print("Error uploading post pic $path: $e");
      }
    }

    return urls;
  }
}
