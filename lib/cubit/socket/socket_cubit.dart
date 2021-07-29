import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_local_storage/local_storage_helper.dart';
import 'package:tada_local_storage/models/message.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  final TadaLocalStorageHelper _localStorageHelper;
  SocketCubit(this._localStorageHelper) : super(SocketInitial());
  late WebSocket socket;
  late List<Message> messages;
  _reconnect(String username) {
    emit(SocketInitial());
    initSocket(username);
  }

  initSocket(String username) async {
    if (state is SocketInitial) {
      try {
        messages = _localStorageHelper.messagesBox.values.toList();
        socket = await WebSocket.connect(
            'wss://nane.tada.team/ws?username=$username');
        socket.asBroadcastStream().listen(
          (data) {
            print(data);
            newMessageRecieved(Message.fromJson(json.decode(data)));
          },
          onError: (error) {
            print(error);
            emit(SocketError(error.toString()));
            _reconnect(username);
          },
          onDone: () {
            _reconnect(username);
          },
        );
      } catch (e) {
        print(e.toString());
        emit(SocketError(e.toString()));
        _reconnect(username);
      }
      emit(SocketInitialised());
    }
  }

  newMessageRecieved(Message message) {
    if (messages.indexWhere((element) =>
            element.created.isAtSameMomentAs(message.created) &&
            element.text == message.text &&
            element.sender.username == message.sender.username &&
            element.room == message.room) ==
        -1) {
      messages.add(message);
      _localStorageHelper.messagesBox.add(message);
    }
  }

  sendMessage(String room, String text) {
    socket.add(json.encode({"room": room, "text": text}));
  }

  closeSink() {
    socket.close();
    emit(SocketInitial());
  }
}
