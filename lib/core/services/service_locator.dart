import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:journijots/core/api/dio_consumer.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/services/cloudinary_service.dart';
import 'package:journijots/features/actions/presentation/manager/repos/create_post_repo_impl.dart';
import 'package:journijots/features/auth/presentation/manager/repos/user_repo_impl.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city/city_repo_impl.dart';
import 'package:journijots/features/explore/presentation/manager/repos/nearby_places/nearby_places_repo_imp.dart';
import 'package:journijots/features/explore/presentation/manager/repos/places_count/places_count_repo_imol.dart';
import 'package:journijots/features/explore/presentation/manager/repos/search_repo/search_repo_impl.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/comment_repo/comment_repo_impl.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/post_repo/post_repo_impl.dart';
import 'package:journijots/features/interests/presentation/manager/cubit/customize_user_cubit.dart';
import 'package:journijots/features/interests/presentation/manager/repos/customize_user_repo_impl.dart';
import 'package:journijots/features/place/presentation/manager/repos/place_repo_impl.dart';
import 'package:journijots/features/profile/presentation/manager/repose/profile_repo_impl.dart';
import 'package:journijots/features/trip/presentation/managers/repos/add_trip_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<Dio>(Dio());
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
  getIt.registerSingleton<CityRepoImpl>(
    CityRepoImpl(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<SearchRepoImpl>(
    SearchRepoImpl(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<NearbyPlacesRepoImp>(
    NearbyPlacesRepoImp(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<PlacesCountRepoImol>(
    PlacesCountRepoImol(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<AddTripRepoImpl>(
    AddTripRepoImpl(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<CreatePostRepoImpl>(
    CreatePostRepoImpl(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<PlaceRepoImpl>(
    PlaceRepoImpl(api: getIt<DioConsumer>()),
  );
  getIt.registerSingleton<CloudinaryService>(
    CloudinaryService(dio: getIt<Dio>()),
  );
}
