import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/features/auth/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices _authServices = AuthServicesImpl();

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await _authServices.login(email, password);
      if (result) {
        final user = _authServices.getUserInit();
        emit(AuthSuccess(user!));
      } else {
        emit(AuthError('Login failed'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await _authServices.register(email, password);
      if (result) {
        final user = _authServices.getUserInit();
        emit(AuthSuccess(user!));
      } else {
        emit(AuthError('Login failed'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
    }
  }

  Future<void> logout() async {
    emit(AuthLoggingOut());
    try {
      await _authServices.logout();
      emit(AuthLoggedOut());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
    }
  }

  Future<void> getUser() async {
    try {
      User? userData = _authServices.getUserInit();
      if (userData != null) {
        emit(AuthSuccess(userData));
      } else {
        emit(AuthError('User not found'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
    }
  }
}
