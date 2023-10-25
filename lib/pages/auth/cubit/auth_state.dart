part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final UserModels user;

  AuthAuthenticated(this.user);
}  

final class AuthUnauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String messageError;

  AuthError(this.messageError);
}
