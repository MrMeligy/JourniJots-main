import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final int? activityId;
  final String? name;
  final String? image;
  final String? type;

  const Activity({this.activityId, this.name, this.image, this.type});

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        activityId: json['activityId'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'activityId': activityId,
        'name': name,
        'image': image,
        'type': type,
      };

  @override
  List<Object?> get props => [activityId, name, image, type];
}
