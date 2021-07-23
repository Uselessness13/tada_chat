import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_api/tada_api.dart';
import 'package:tada_models/tada_models.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final TadaApiHelper _tadaApiHelper;
  ChatCubit(this._tadaApiHelper) : super(ChatInitial());

  loadRoom(Room room) async {
    emit(ChatLoading());
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
}
