import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_api/tada_api.dart';
import 'package:tada_models/tada_models.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final TadaApiHelper _tadaApiHelper;
  RoomsCubit(this._tadaApiHelper) : super(RoomsInitial());

  loadRooms() async {
    emit(RoomsLoading());
    try {
      final rooms = await _tadaApiHelper.getRoomList();
      rooms.sort((room1, room2) => room2.lastMessage!.created!
          .compareTo(room1.lastMessage!.created ?? DateTime.now()));
      emit(RoomsLoaded(rooms));
    } on TadaApiException catch (e) {
      emit(RoomsError(e.message));
    } on Exception catch (e) {
      emit(RoomsError(e.toString()));
    }
  }

  
}
