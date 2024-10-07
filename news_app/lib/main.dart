import 'package:flutter/material.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/core/utils/app_theme.dart';

import 'core/utils/route/app_router.dart';
import 'core/utils/route/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.mainTheme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
