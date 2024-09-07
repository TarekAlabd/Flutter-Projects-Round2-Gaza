import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/utils/app_constants.dart';
import 'package:ecommerce/utils/app_router.dart';
import 'package:ecommerce/utils/app_routes.dart';
import 'package:ecommerce/utils/app_theme.dart';
import 'package:ecommerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.authcheck();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(
            bloc: BlocProvider.of<AuthCubit>(context),
            buildWhen: (previous, current) => current is AuthInitial || current is AuthSuccess,
            builder: (context, state) {
              return MaterialApp(
                title: AppConstants.appName,
                theme: AppTheme.lightTheme(),
                initialRoute: state is AuthSuccess ? AppRoutes.home : AppRoutes.signIn,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        }
      ),
    );
  }
}
