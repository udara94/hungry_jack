
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {}

class CheckAuthentication extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}