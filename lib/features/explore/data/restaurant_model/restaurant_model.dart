import 'package:equatable/equatable.dart';

class RestaurantModel extends Equatable {
  final String? category;
  final int? id;
  final String? name;
  final String? image;
  final String? address;
  final String? city;
  final double? rating;
  final int? ratingCount;
  final double? longitude;
  final double? latitude;

  const RestaurantModel({
    this.category,
    this.id,
    this.name,
    this.image,
    this.address,
    this.city,
    this.rating,
    this.ratingCount,
    this.longitude,
    this.latitude,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      category: json['category'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: json['ratingCount'] as int?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'id': id,
        'name': name,
        'image': image,
        'address': address,
        'city': city,
        'rating': rating,
        'ratingCount': ratingCount,
        'longitude': longitude,
        'latitude': latitude,
      };

  @override
  List<Object?> get props {
    return [
      category,
      id,
      name,
      image,
      address,
      city,
      rating,
      ratingCount,
      longitude,
      latitude,
    ];
  }
}
