part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFailed extends AuthState {
  final String message;

  AuthFailed(this.message);
}

final class SigningOut extends AuthState {}

final class SignedOut extends AuthState {}
