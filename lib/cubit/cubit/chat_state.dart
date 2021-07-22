part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);
}
class ChatLoaded extends ChatState {
  final List<ServerMessage> messages;

  ChatLoaded(this.messages);
}
