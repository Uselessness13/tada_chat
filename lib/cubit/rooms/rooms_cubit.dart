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

  createRoom(Room room) {
    _localStorageHelper.roomsBox.add(room);
    _emitRooms();
  }

  loadRooms() async {
    emit(RoomsLoading());
    try {
      var localRooms = _localStorageHelper.roomsBox.values.toList();
      emit(RoomsLoaded(localRooms));
      final rooms = await _tadaApiHelper.getRoomList();
      rooms.sort((room1, room2) =>
          room2.message!.created.compareTo(room1.message!.created));
      var newRooms = rooms.where((element) =>
          localRooms.indexWhere((el) => el.name == element.name) == -1);
      _localStorageHelper.roomsBox.addAll(newRooms);
      _emitRooms();
    } on TadaApiException catch (e) {
      emit(RoomsError(e.message));
    } on Exception catch (e) {
      emit(RoomsError(e.toString()));
    }
  }

  updateRoom(Room room) {
    final index = _localStorageHelper.roomsBox.values
        .toList()
        .indexWhere((element) => element.name == room.name);
    _localStorageHelper.roomsBox.putAt(index, room);
    _emitRooms();
  }

  _emitRooms() {
    final rooms = _localStorageHelper.roomsBox.values.toList();
    rooms.sort((r1, r2) => r1.message == null
        ? 1
        : r2.message == null
            ? -1
            : (r2.message?.created ?? DateTime.now())
                .compareTo((r1.message?.created ?? DateTime.now())));
    emit(RoomsLoaded(rooms));
  }
}
