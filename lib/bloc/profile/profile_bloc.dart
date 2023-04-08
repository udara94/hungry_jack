
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_jack/bloc/profile/profile_event.dart';
import 'package:hungry_jack/bloc/profile/profile_state.dart';
import 'package:hungry_jack/models/user.dart';
import 'package:hungry_jack/services/firebase_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  final FirebaseService _firebaseService = FirebaseService();
  ProfileBloc(): super(ProfileEmpty()){
    on<LoadUserProfile>((event, emit) async {
      try{
        emit(ProfileLoading());
        UserProfile profile = await _firebaseService.getProfile();
        emit(ProfileLoaded(profile));
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
        emit(ProfileLoadError());
      }
    });
    on<CheckEmailVerified>((event, emit) async {
      try{
        emit(VerifyEmailInProgress());
        bool isVerified = await _firebaseService.checkEmailVerified();
        if(!isVerified){
          return emit(VerifyEmailError());
        }
        emit(VerifyEmailCompleted());
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
        emit(VerifyEmailError());
      }
    });
  }

}