import 'package:equatable/equatable.dart';

class NearbyPlaceModel extends Equatable {
  final String? type;
  final int? id;
  final String? name;
  final String? image;
  final double? rating;
  final int? ratingCount;
  final String? address;

  const NearbyPlaceModel({
    this.type,
    this.id,
    this.name,
    this.image,
    this.rating,
    this.ratingCount,
    this.address,
  });

  factory NearbyPlaceModel.fromJson(Map<String, dynamic> json) {
    return NearbyPlaceModel(
      type: json['type'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: json['ratingCount'] as int?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'name': name,
        'image': image,
        'rating': rating,
        'ratingCount': ratingCount,
        'address': address,
      };

  @override
  List<Object?> get props {
    return [
      type,
      id,
      name,
      image,
      rating,
      ratingCount,
      address,
    ];
  }
}
