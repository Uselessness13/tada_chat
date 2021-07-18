import 'package:tada_api/get_room_history.dart';
import 'package:tada_api/get_room_list.dart';
import 'package:tada_models/tada_models.dart';

import 'get_server_settings.dart';

class TadaApiHelper {
  Future<List<ServerMessage>> getRoomHistory(String roomName) =>
      GetRoomHistoryProvider().execute(roomName);

  Future<List<Message>> getRoomList() => GetRoomListProvider().execute();

  Future<ServerSettings> getServerSettings() =>
      GetServerSettingsProvider().execute();
}
