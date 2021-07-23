import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_api/tada_api.dart';
import 'package:tada_local_storage/local_storage_helper.dart';
import 'package:tada_local_storage/models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final TadaLocalStorageHelper _localStorageHelper;
  final TadaApiHelper _tadaApiHelper;
  ChatCubit(this._tadaApiHelper, this._localStorageHelper)
      : super(ChatInitial());

  loadRoom(String room, String username) async {
    emit(ChatLoading());
    try {
      final messages = await _tadaApiHelper.getRoomHistory(room);
      List<Message> roomMessages = _localStorageHelper.messagesBox.values
          .toList()
          .where((element) => element.room == room)
          .toList();
      var newMessages = messages.toSet().difference(roomMessages.toSet());
      _localStorageHelper.messagesBox.addAll(newMessages);
      emit(ChatLoaded(messages));
    } on TadaApiException catch (e) {
      emit(ChatError(e.message));
    } on Exception catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  addMessage(Message message) {
    ChatState lastState = state as ChatLoaded;
    emit(ChatLoaded([...lastState.messages, message]))
  }
}
