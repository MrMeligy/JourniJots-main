import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:journijots/core/api/dio_consumer.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/features/auth/presentation/manager/repos/user_repo_impl.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/comment_repo/comment_repo_impl.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/post_repo/post_repo_impl.dart';
import 'package:journijots/features/interests/presentation/manager/cubit/customize_user_cubit.dart';
import 'package:journijots/features/interests/presentation/manager/repos/customize_user_repo_impl.dart';
import 'package:journijots/features/profile/presentation/manager/repose/profile_posts_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerSingleton<DioConsumer>(DioConsumer(dio: Dio()));
  getIt.registerSingleton<UserRepoImpl>(
    UserRepoImpl(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<CustomizeUserRepoImpl>(
    CustomizeUserRepoImpl(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<CustomizeUserCubit>(
    CustomizeUserCubit(getIt<CustomizeUserRepoImpl>()),
  );
  getIt.registerSingleton<PostRepoImpl>(
    PostRepoImpl(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<CommentRepoImpl>(
    CommentRepoImpl(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<ProfileRepoImpl>(
    ProfileRepoImpl(api: getIt<DioConsumer>()),
  );
}
