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
      : super(RoomsInitial()) {
    _localStorageHelper.messagesBox.watch().listen((event) {
      if (state is RoomsLoaded) {
        updateRoom(Room(message: event.value, name: event.value.room));
      }
    });
  }

  loadRooms() async {
    emit(RoomsLoading());
    try {
      emit(RoomsLoaded(_localStorageHelper.roomsBox.values.toList()));
      final rooms = await _tadaApiHelper.getRoomList();
      rooms.sort((room1, room2) =>
          room2.message.created.compareTo(room1.message.created));
      _localStorageHelper.roomsBox.clear();
      _localStorageHelper.roomsBox.addAll(rooms);
      emit(RoomsLoaded(rooms));
    } on TadaApiException catch (e) {
      emit(RoomsError(e.message));
    } on Exception catch (e) {
      emit(RoomsError(e.toString()));
    }
  }

  updateRoom(Room room) {
    RoomsLoaded lastState = state as RoomsLoaded;
    List<Room> rooms = lastState.rooms;
    rooms.removeWhere((el) => el.name == room.name);
    rooms.add(room);
    rooms.sort((room1, room2) =>
        room2.message.created.compareTo(room1.message.created));
    emit(RoomsLoaded(rooms));
  }
}
