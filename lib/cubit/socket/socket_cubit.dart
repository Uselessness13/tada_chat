import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_local_storage/models/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  SocketCubit() : super(SocketInitial());
  late WebSocketChannel channel;

  initSocket(String username) async {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://nane.tada.team/ws?username=$username'),
    );
    channel.stream.listen((event) {
      newMessageRecieved(Message.fromJson(json.decode(event)));
    });
  }

  newMessageRecieved(Message message) {
    emit(NewMessageRecieved(message));
  }

  sendMessage(String room, String text) {
    channel.sink.add({"room": room, "text": text});
  }
}
