import 'package:equatable/equatable.dart';

class NearByPlaceModel extends Equatable {
  final String? type;
  final int? id;
  final String? name;
  final String? image;
  final double? rating;
  final int? ratingCount;
  final String? address;

  const NearByPlaceModel({
    this.type,
    this.id,
    this.name,
    this.image,
    this.rating,
    this.ratingCount,
    this.address,
  });

  factory NearByPlaceModel.fromJson(Map<String, dynamic> json) {
    return NearByPlaceModel(
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
