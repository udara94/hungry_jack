import 'package:equatable/equatable.dart';
import 'package:hungry_jack/models/user.dart';

class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileEmpty extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;

  ProfileLoaded(this.profile);
}

class ProfileLoadError extends ProfileState {}
