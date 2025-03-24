import 'package:equatable/equatable.dart';

class InterestsModel extends Equatable {
  final String? message;
  final List<String>? intersts;

  const InterestsModel({this.message, this.intersts});

  factory InterestsModel.fromJson(Map<String, dynamic> json) {
    return InterestsModel(
      message: json['message'] as String?,
      intersts: json['intersts'] as List<String>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'intersts': intersts,
      };

  @override
  List<Object?> get props => [message, intersts];
}
