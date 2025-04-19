import 'package:dio/dio.dart';
import 'package:journijots/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 401: //unauthorized
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 403: //forbidden
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 404: // not found
          if (e.response?.headers['content-type']?.contains('text/plain') ==
              true) {
            // Handle plain text error message
            final errorMessage = e.response!.data.toString();
            throw ServerException(
              errModel: ErrorModel(
                errorMessage: errorMessage,
                statusCode: e.response!.statusCode,
              ),
            );
          } else {
            // Handle JSON error response
            try {
              throw ServerException(
                errModel: ErrorModel.fromJson(e.response!.data),
              );
            } catch (parseError) {
              // Fallback if parsing fails
              throw ServerException(
                errModel: ErrorModel(
                  errorMessage: e.response?.data?.toString() ?? "Unknown error",
                  statusCode: e.response!.statusCode,
                ),
              );
            }
          }
        case 409: //cofficient
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 422: //  Unprocessable Entity
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 504: // Server exception
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}
