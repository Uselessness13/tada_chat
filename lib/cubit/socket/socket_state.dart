part of 'socket_cubit.dart';

@immutable
abstract class SocketState {}

class SocketInitial extends SocketState {}

class NewMessageRecieved extends SocketState {
  final Message message;

  NewMessageRecieved(this.message);
}
