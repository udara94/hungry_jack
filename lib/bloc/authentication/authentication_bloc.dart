
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_jack/bloc/authentication/authentication_event.dart';
import 'package:hungry_jack/bloc/authentication/authentication_state.dart';

import '../../services/firebase_service.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  final FirebaseService _firebaseService = FirebaseService();
  AuthenticationBloc(): super(AuthenticationEmpty()){
    on<CheckAuthentication>((event, emit) {
      try{
        final currentUser =  _firebaseService.firebaseAuth.currentUser;
        if(currentUser != null){
          emit(AuthenticationValid());
        }else{
          emit(UnAuthentication());
        }
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
        emit(AuthenticationError());
      }
    });
    on<SignUpUser>((event, emit) async {
      try{
        emit(SignUpInProgress());
        print(event.userProfile);
        await _firebaseService.createAccount(event.userProfile);
        emit(SignUpCompleted());
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
        emit(SignUpError());
      }
    });
  }

}