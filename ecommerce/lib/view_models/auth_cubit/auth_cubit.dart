import 'package:ecommerce/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authServices = AuthServices();

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.signInWithEmailAndPassword(email, password);
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailed('Incorrect email or password!'));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.signUpWithEmailAndPassword(email, password);
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailed('Failed to sign up!'));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void authcheck() {
    final user = authServices.currentUser;
    if (user != null) {
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> signOut() async {
    emit(SigningOut());
    try {
      await authServices.signOut();
      emit(SignedOut());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
