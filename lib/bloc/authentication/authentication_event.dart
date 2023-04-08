import 'package:equatable/equatable.dart';
import 'package:hungry_jack/models/user.dart';

abstract class AuthenticationEvent extends Equatable {}

class CheckAuthentication extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SignOutEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SignUpUser extends AuthenticationEvent {
  final UserProfile userProfile;

  SignUpUser(this.userProfile);

  @override
  List<Object?> get props => [];
}

class SignInUser extends AuthenticationEvent {
  final String email;
  final String password;
  SignInUser(this.email, this.password);

  @override
  List<Object?> get props => [];
}
