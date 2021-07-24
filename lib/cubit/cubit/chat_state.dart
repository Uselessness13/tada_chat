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
  final List<Message> messages;
  final Room room;

  ChatLoaded(this.messages, this.room);
}
