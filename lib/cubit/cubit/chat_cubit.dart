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
          addMessage(event.value);
      }
    });
  }

  loadRoom(String room) async {
    emit(ChatLoading());
    try {
      List<Message> roomMessages = _localStorageHelper.messagesBox.values
          .toList()
          .where((element) => element.room == room)
          .toList();
      roomMessages.sort((m1, m2) => m2.created.isAfter(m1.created) ? 1 : -1);
      emit(ChatLoaded(roomMessages, Room(name: room)));
      final messages = await _tadaApiHelper.getRoomHistory(room);
      var newMessages = messages.where((message) =>
          roomMessages.indexWhere((localMessage) =>
              localMessage.room == message.room &&
              localMessage.text == message.text &&
              localMessage.sender.username == message.sender.username) ==
          -1);
      _localStorageHelper.messagesBox.addAll(newMessages);
      messages.sort((m1, m2) => m2.created.isAfter(m1.created) ? 1 : -1);
      var resMessages = _localStorageHelper.messagesBox.values
          .toList()
          .where((element) => element.room == room)
          .toList();
      resMessages.sort((m1, m2) => m2.created.compareTo(m1.created));
      emit(ChatLoaded(resMessages, Room(name: room)));
    } on TadaApiException catch (e) {
      if (e is TadaApiNotFoundException)
        emit(ChatLoaded(List.empty(), Room(name: room)));
      else
        emit(ChatError(e.message));
    } on Exception catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  addMessage(Message message) {
    ChatLoaded lastState = state as ChatLoaded;
    emit(ChatLoaded([
      message,
      ...lastState.messages,
    ], Room(name: message.room)));
  }
}
