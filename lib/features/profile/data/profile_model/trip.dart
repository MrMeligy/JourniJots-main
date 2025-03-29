import 'package:equatable/equatable.dart';

class Trip extends Equatable {
  final String? city;
  final String? startDate;

  const Trip({this.city, this.startDate});

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        city: json['city'] as String?,
        startDate: json['startDate'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'city': city,
        'startDate': startDate,
      };

  @override
  List<Object?> get props => [city, startDate];
}
