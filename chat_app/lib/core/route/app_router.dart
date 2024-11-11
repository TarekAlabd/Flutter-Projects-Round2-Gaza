import 'package:chat_app/core/route/app_routes.dart';
import 'package:chat_app/features/auth/views/pages/auth_page.dart';
import 'package:chat_app/features/chat/chat_cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/views/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
          settings: settings,
        );
      case AppRoutes.chat:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ChatCubit();
              cubit.getMessages();
              return cubit;
            },
            child: const ChatPage(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
          settings: settings,
        );
    }
  }
}
