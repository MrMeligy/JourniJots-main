import 'package:equatable/equatable.dart';

class SearchModel extends Equatable {
  final String type;
  final int id;
  final String? image;
  final String name;

  const SearchModel(
      {required this.type, required this.id, this.image, required this.name});

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        type: json['type'] as String,
        id: json['id'] as int,
        image: json['image'] as String?,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'image': image,
        'name': name,
      };

  @override
  List<Object?> get props => [type, id, image, name];
}
