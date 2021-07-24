import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_local_storage/local_storage_helper.dart';
import 'package:tada_local_storage/models/message.dart';
import 'package:web_socket_channel/io.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  final TadaLocalStorageHelper _localStorageHelper;
  SocketCubit(this._localStorageHelper) : super(SocketInitial());
  late IOWebSocketChannel channel;

  initSocket(String username) async {
    if (state is SocketInitial) {
      channel = IOWebSocketChannel.connect(
        Uri.parse('wss://nane.tada.team/ws?username=$username').toString(),
      );
      channel.stream.listen((event) {
        print(event);
        newMessageRecieved(Message.fromJson(json.decode(event)));
      });
      channel.sink.done.then((value) {
        print(value.last);
      });
      emit(SocketInitialised());
    }
  }

  newMessageRecieved(Message message) {
    _localStorageHelper.messagesBox.add(message);
  }

  sendMessage(String room, String text) {
    channel.sink.add(json.encode({"room": room, "text": text}));
  }

  closeSink() {
    channel.innerWebSocket?.close();
    channel.sink.close();
    emit(SocketInitial());
  }
}
