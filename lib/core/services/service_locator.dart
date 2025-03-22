import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:journijots/core/api/dio_consumer.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/features/auth/presentation/manager/repos/user_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerSingleton<DioConsumer>(DioConsumer(dio: Dio()));
  getIt.registerSingleton<UserRepoImpl>(
    UserRepoImpl(api: getIt<DioConsumer>()),
  );
}
