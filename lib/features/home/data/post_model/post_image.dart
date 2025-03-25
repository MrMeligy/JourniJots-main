import 'package:equatable/equatable.dart';

class PostImage extends Equatable {
  final int? id;
  final String? imageData;

  const PostImage({this.id, this.imageData});

  factory PostImage.fromJson(Map<String, dynamic> json) => PostImage(
        id: json['id'] as int?,
        imageData: json['imageData'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageData': imageData,
      };

  @override
  List<Object?> get props => [id, imageData];
}
