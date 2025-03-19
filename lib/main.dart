import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/api/dio_consumer.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/routes/app_routing.dart';
import 'package:journijots/features/auth/presentation/manager/user_cubit/user_cubit.dart';
import 'package:journijots/journijots_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  await ScreenUtil.ensureScreenSize();
  runApp(
    BlocProvider(
      create: (context) => UserCubit(DioConsumer(dio: Dio())),
      child: JournijotsApp(
        appRouting: AppRouting(),
      ),
    ),
  );
}
