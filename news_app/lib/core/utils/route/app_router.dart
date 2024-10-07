import 'package:flutter/cupertino.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/features/home/views/home_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
      default:
        return CupertinoPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
    }
  }
}
