import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/routes/app_routing.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/auth/presentation/manager/repos/user_repo_impl.dart';
import 'package:journijots/features/auth/presentation/manager/user_cubit/user_cubit.dart';
import 'package:journijots/features/explore/presentation/manager/cubits/search_cubit/search_cubit.dart';
import 'package:journijots/features/explore/presentation/manager/repos/search_repo/search_repo_impl.dart';
import 'package:journijots/features/place/presentation/manager/place_cubit/place_cubit.dart';
import 'package:journijots/features/place/presentation/manager/repos/place_repo_impl.dart';
import 'package:journijots/journijots_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<CacheHelper>().init();
  await ScreenUtil.ensureScreenSize();
  Gemini.init(apiKey: gemeniApiKey);
  getIt.registerSingleton<Gemini>(Gemini.instance);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(getIt<UserRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => SearchCubit(getIt<SearchRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => PlaceCubit(getIt<PlaceRepoImpl>()),
        ),
      ],
      child: JournijotsApp(
        appRouting: AppRouting(),
      ),
    ),
  );
}
