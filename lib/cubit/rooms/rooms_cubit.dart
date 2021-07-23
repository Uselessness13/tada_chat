import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_api/tada_api.dart';
import 'package:tada_local_storage/local_storage_helper.dart';
import 'package:tada_local_storage/models/room.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final TadaApiHelper _tadaApiHelper;
  final TadaLocalStorageHelper _localStorageHelper;
  RoomsCubit(this._tadaApiHelper, this._localStorageHelper)
      : super(RoomsInitial());

  loadRooms() async {
    emit(RoomsLoading());
    try {
      final rooms = await _tadaApiHelper.getRoomList();
      rooms.sort((room1, room2) => room2.message.created!
          .compareTo(room1.message.created ?? DateTime.now()));
      _localStorageHelper.roomsBox.clear();
      _localStorageHelper.roomsBox.addAll(rooms);
      emit(RoomsLoaded(rooms));
    } on TadaApiException catch (e) {
      emit(RoomsError(e.message));
    } on Exception catch (e) {
      emit(RoomsError(e.toString()));
    }
  }
}
