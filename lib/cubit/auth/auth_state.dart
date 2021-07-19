part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenthicated extends AuthState {
  final String username;

  Authenthicated(this.username);
}

class Unauthenthicated extends AuthState {}
