import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/routes/app_routing.dart';
import 'package:journijots/journijots_app.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(
    JournijotsApp(
      appRouting: AppRouting(),
    ),
  );
}
