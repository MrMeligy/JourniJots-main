import 'package:equatable/equatable.dart';

class Hotel extends Equatable {
  final int? hotelId;
  final String? name;
  final String? image;
  final String? type;

  const Hotel({this.hotelId, this.name, this.image, this.type});

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        hotelId: json['hotelId'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'hotelId': hotelId,
        'name': name,
        'image': image,
        'type': type,
      };

  @override
  List<Object?> get props => [hotelId, name, image, type];
}
