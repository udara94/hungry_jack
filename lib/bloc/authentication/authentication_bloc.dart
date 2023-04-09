import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_jack/bloc/authentication/authentication_event.dart';
import 'package:hungry_jack/bloc/authentication/authentication_state.dart';

import '../../services/firebase_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseService _firebaseService = FirebaseService();

  AuthenticationBloc() : super(AuthenticationEmpty()) {
    on<CheckAuthentication>((event, emit) {
      try {
        final currentUser = _firebaseService.firebaseAuth.currentUser;
        if (currentUser != null) {
          emit(AuthenticationValid());
        } else {
          emit(UnAuthentication());
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(AuthenticationError());
      }
    });
    on<SignUpUser>((event, emit) async {
      try {
        emit(SignUpInProgress());
        await _firebaseService.createAccount(event.userProfile);
        emit(SignUpCompleted());
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(SignUpError());
      }
    });
    on<SignOutEvent>((event, emit) async {
      try {
        emit(SignOutInProgress());
        await _firebaseService.signOut();
        emit(SignUpCompleted());
      } catch (e) {
        emit(SignOutError());
      }
    });
    on<SignInUser>((event, emit) async {
      try {
        emit(SignInInProgress());
        String? response =
            await _firebaseService.loginUser(event.email, event.password);
        if (response != null) {
          return emit(SignInError(response));
        }
        emit(SignInComplete());
      } catch (e) {
        emit(SignInError(e.toString()));
      }
    });
    on<ResetPassword>((event, emit) async {
      try {
        emit(ResetPasswordInProgress());
        await _firebaseService.resetPassword(email: event.email);
        emit(ResetPasswordCompleted());
      } catch (e) {
        emit(ResetPasswordError(e.toString()));
      }
    });
  }
}
