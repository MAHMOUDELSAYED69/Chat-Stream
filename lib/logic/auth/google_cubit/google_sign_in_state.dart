part of 'google_sign_in_cubit.dart';

@immutable
abstract class GoogleSignInState {}

class GoogleSignInInitial extends GoogleSignInState {}

class GoogleSignInLoading extends GoogleSignInState {}

class GoogleSignInSuccess extends GoogleSignInState {
  final dynamic user;

  GoogleSignInSuccess({required this.user});
}

class GoogleSignInFailure extends GoogleSignInState {
  final String message;

  GoogleSignInFailure({required this.message});
}
