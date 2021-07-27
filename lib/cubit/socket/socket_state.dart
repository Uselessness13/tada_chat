part of 'socket_cubit.dart';

@immutable
abstract class SocketState {}

class SocketInitial extends SocketState {}

class SocketError extends SocketState {
  final String message;

  SocketError(this.message);
}

class SocketInitialised extends SocketState {}
