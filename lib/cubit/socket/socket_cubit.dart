import 'dart:convert';
import 'dart:html';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_local_storage/local_storage_helper.dart';
import 'package:tada_local_storage/models/message.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  final TadaLocalStorageHelper _localStorageHelper;
  SocketCubit(this._localStorageHelper) : super(SocketInitial());
  late WebSocketChannel channel;

  _reconnect(String username) {
    emit(SocketInitial());
    initSocket(username);
  }

  initSocket(String username) async {
    if (state is SocketInitial) {
      channel = WebSocketChannel.connect(
        Uri.parse('wss://nane.tada.team/ws?username=$username'),
      );
      channel.stream.asBroadcastStream().listen(
            (event) {
              print(event);
              newMessageRecieved(Message.fromJson(json.decode(event)));
            },
            onDone: () => _reconnect(username),
            onError: (error) {
              print(error);
              emit(SocketError(error.toString()));
              _reconnect(username);
            },
          );
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
    channel.sink.close();
    emit(SocketInitial());
  }
}
