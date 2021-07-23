import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_api/tada_api.dart';
import 'package:tada_local_storage/models/room.dart';
import 'package:tada_local_storage/models/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final TadaApiHelper _tadaApiHelper;
  ChatCubit(this._tadaApiHelper) : super(ChatInitial());

  late WebSocketChannel channel;

  loadRoom(Room room, String username) async {
    emit(ChatLoading());
    channel = WebSocketChannel.connect(
      Uri.parse('wss://nane.tada.team/ws?username=$username'),
    );  
    channel.stream.listen((event) {
      print(event);
    });
    try {
      final messages = await _tadaApiHelper.getRoomHistory(room.name);
      messages.sort(
          (m1, m2) => m2.created!.compareTo(m1.created ?? DateTime.now()));
      emit(ChatLoaded(messages));
    } on TadaApiException catch (e) {
      emit(ChatError(e.message));
    } on Exception catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  sendMessage(String room, String text) {
    channel.sink.add({
      "room": room,
      "text": text,
    });
  }
}
