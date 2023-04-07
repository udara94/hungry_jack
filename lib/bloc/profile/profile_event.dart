
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable{}

class LoadUserProfile extends ProfileEvent {
  @override
  List<Object?> get props => [];
}