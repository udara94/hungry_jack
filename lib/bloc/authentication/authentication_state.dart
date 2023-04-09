import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationEmpty extends AuthenticationState {}

class UnAuthentication extends AuthenticationState {}

class AuthenticationValid extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {}

class SignUpEmpty extends AuthenticationState {}

class SignUpInProgress extends AuthenticationState {}

class SignUpCompleted extends AuthenticationState {}

class SignUpError extends AuthenticationState {}

class SignOutBefore extends AuthenticationState {}

class SignOutInProgress extends AuthenticationState {}

class SignOutComplete extends AuthenticationState {}

class SignOutError extends AuthenticationState {}

class SignInInProgress extends AuthenticationState {}

class SignInComplete extends AuthenticationState {}

class SignInError extends AuthenticationState {
  final String error;
  SignInError(this.error);
}

class ResetPasswordInProgress extends AuthenticationState {}

class ResetPasswordCompleted extends AuthenticationState {}

class ResetPasswordError extends AuthenticationState {
  final String error;
  ResetPasswordError(this.error);
}
