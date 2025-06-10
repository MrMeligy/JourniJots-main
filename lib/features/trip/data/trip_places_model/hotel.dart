import 'package:equatable/equatable.dart';

class Hotel extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final double? rating;
  final int? ratingCount;
  final String? address;
  final String? city;
  final String? type;

  const Hotel({
    this.id,
    this.name,
    this.image,
    this.rating,
    this.ratingCount,
    this.address,
    this.city,
    this.type,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
        ratingCount: json['ratingCount'] as int?,
        address: json['address'] as String?,
        city: json['city'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'rating': rating,
        'ratingCount': ratingCount,
        'address': address,
        'city': city,
        'type': type,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      image,
      rating,
      ratingCount,
      address,
      city,
      type,
    ];
  }
}
