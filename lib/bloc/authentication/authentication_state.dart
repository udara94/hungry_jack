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
