import 'package:tada_api/get_room_history.dart';
import 'package:tada_api/get_room_list.dart';
import 'package:tada_local_storage/tada_local_storage.dart';

import 'get_server_settings.dart';

class TadaApiHelper {
  Future<List<Message>> getRoomHistory(String roomName) =>
      GetRoomHistoryProvider().execute(roomName);

  Future<List<Room>> getRoomList() => GetRoomListProvider().execute();

  Future<ServerSettings> getServerSettings() =>
      GetServerSettingsProvider().execute();
}
