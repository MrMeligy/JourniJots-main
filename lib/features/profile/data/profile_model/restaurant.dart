import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final int? restaurantId;
  final String? name;
  final String? image;
  final String? type;

  const Restaurant({this.restaurantId, this.name, this.image, this.type});

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        restaurantId: json['restaurantId'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'restaurantId': restaurantId,
        'name': name,
        'image': image,
        'type': type,
      };

  @override
  List<Object?> get props => [restaurantId, name, image, type];
}
