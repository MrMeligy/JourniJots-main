import 'package:dio/dio.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/services/service_locator.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        getIt<CacheHelper>().getData(key: ApiKey.token) != null
            ? 'Bearer ${getIt<CacheHelper>().getDataString(key: ApiKey.token)}'
            : null;
    super.onRequest(options, handler);
  }
}
