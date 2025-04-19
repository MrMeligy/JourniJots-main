class ErrorModel {
  final String errorMessage;
  final int? statusCode;
  // other fields as needed

  ErrorModel({
    required this.errorMessage,
    this.statusCode,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      errorMessage: json['message'] ?? '',
      statusCode: json['statusCode'],
      // other fields
    );
  }
}
