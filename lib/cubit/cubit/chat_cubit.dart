import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_api/tada_api.dart';
import 'package:tada_local_storage/local_storage_helper.dart';
import 'package:tada_local_storage/models/message.dart';
import 'package:tada_local_storage/models/room.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final TadaLocalStorageHelper _localStorageHelper;
  final TadaApiHelper _tadaApiHelper;
  ChatCubit(this._tadaApiHelper, this._localStorageHelper)
      : super(ChatInitial()) {
    _localStorageHelper.messagesBox.watch().listen((event) {
      if (state is ChatLoaded) {
        if ((event.value as Message).room == (state as ChatLoaded).room.name)
          _emitMessages((event.value as Message).room);
      }
    });
  }

  List<Message> _getRoomMessages(String room) {
    return _localStorageHelper.messagesBox.values
        .toList()
        .where((element) => element.room == room)
        .toList();
  }

  _emitMessages(String room) {
    final roomMessages = _getRoomMessages(room);
    roomMessages.sort((r1, r2) => r2.created.compareTo(r1.created));
    emit(ChatLoaded(roomMessages, Room(name: room)));
  }

  loadRoom(String room, [bool newRoom = false]) async {
    emit(ChatLoading());
    try {
      _emitMessages(room);
      if (!newRoom) {
        final messages = await _tadaApiHelper.getRoomHistory(room);
        final roomMessages = _getRoomMessages(room);
        var newMessages = messages.where((message) =>
            roomMessages.indexWhere((localMessage) =>
                localMessage.room == message.room &&
                localMessage.text == message.text &&
                localMessage.sender.username == message.sender.username) ==
            -1);
        _localStorageHelper.messagesBox.addAll(newMessages);
        _emitMessages(room);
      }
    } on TadaApiException catch (e) {
      if (e is TadaApiNotFoundException)
        emit(ChatLoaded(List.empty(), Room(name: room)));
      else
        emit(ChatError(e.message));
    } on Exception catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
