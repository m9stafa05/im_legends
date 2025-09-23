part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserProfileModel player;
  ProfileSuccess({required this.player});
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure(this.message);
}

class ProfileLoggedOut extends ProfileState {} // 🔥 new state
