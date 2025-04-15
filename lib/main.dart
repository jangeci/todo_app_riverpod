import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/deep_links/deep_link_provider.dart';
import 'package:todo_app/common/routes.dart';
import 'package:todo_app/common/utils/app_styles.dart';
import 'package:todo_app/global.dart';

void main() async {
  await Global.init();

  runApp(
    const ProviderScope(
      child: DeepLinkHandler(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp.router(
        theme: AppTheme.appThemeData,
        routerConfig: router,
      ),
    );
  }
}
