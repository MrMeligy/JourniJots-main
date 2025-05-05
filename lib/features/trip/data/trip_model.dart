import 'package:equatable/equatable.dart';

class TripModel extends Equatable {
  final int? userId;
  final String? userName;
  final int? tripId;
  final String? city;
  final String? date;

  const TripModel({
    this.userId,
    this.userName,
    this.tripId,
    this.city,
    this.date,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        userId: json['userId'] as int?,
        userName: json['userName'] as String?,
        tripId: json['tripId'] as int?,
        city: json['city'] as String?,
        date: json['date'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'tripId': tripId,
        'city': city,
        'date': date,
      };

  @override
  List<Object?> get props => [userId, userName, tripId, city, date];
}
