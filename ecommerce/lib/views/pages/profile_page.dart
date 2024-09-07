import 'package:ecommerce/utils/app_routes.dart';
import 'package:ecommerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Center(
      child: BlocConsumer<AuthCubit, AuthState>(
        bloc: authCubit,
        listenWhen: (previous, current) =>
            current is AuthFailed || current is SignedOut,
        listener: (context, state) {
          if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is SignedOut) {
            Navigator.of(context, rootNavigator: true).pushReplacementNamed(AppRoutes.signIn);
          }
        },
        buildWhen: (previous, current) =>
            current is SigningOut ||
            current is SignedOut ||
            current is AuthFailed,
        builder: (context, state) {
          if (state is SigningOut) {
            return const MainButton(isLoading: true,);
          }
          return MainButton(
            label: 'Sign Out',
            onPressed: () async => await authCubit.signOut(),
          );
        },
      ),
    );
  }
}
