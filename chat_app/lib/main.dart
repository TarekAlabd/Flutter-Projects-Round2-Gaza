import 'package:chat_app/core/route/app_router.dart';
import 'package:chat_app/core/route/app_routes.dart';
import 'package:chat_app/core/utils/app_constants.dart';
import 'package:chat_app/core/utils/app_theme.dart';
import 'package:chat_app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.getUser();
        return cubit;
      },
      child: Builder(builder: (context) {
        return BlocBuilder<AuthCubit, AuthState>(
          bloc: BlocProvider.of<AuthCubit>(context),
          builder: (context, state) {
            return MaterialApp(
              title: AppConstants.appName,
              theme: AppTheme.mainTheme,
              initialRoute:
                  state is AuthSuccess ? AppRoutes.chat : AppRoutes.auth,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        );
      }),
    );
  }
}
