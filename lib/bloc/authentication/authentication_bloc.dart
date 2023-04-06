
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_jack/bloc/authentication/authentication_event.dart';
import 'package:hungry_jack/bloc/authentication/authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  AuthenticationBloc(): super(AuthenticationEmpty()){
    on<CheckAuthentication>((event, emit) {
      try{
        final currentUser = FirebaseAuth.instance.currentUser;
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
  }

  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event)async*{
    if(event is CheckAuthentication){
      try{
        final currentUser = FirebaseAuth.instance.currentUser;
        if(currentUser != null){
          yield AuthenticationValid();
        }else{
          yield UnAuthentication();
        }
      }catch(e){
        yield AuthenticationError();
      }
    }
  }

}