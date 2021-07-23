import 'package:dio/dio.dart';
import 'package:tada_api/api_exception.dart';
import 'package:tada_api/constants.dart';
import 'package:tada_api/rest_helper.dart';
import 'package:tada_local_storage/models/room.dart';
import 'api_provider.dart';

class GetRoomListProvider implements ApiProvider<void, List<Room>> {
  Future<List<Room>> execute([_]) async {
    Response response = await RestHelper.internal().get(Constants.ROOMS);
    if (response.statusCode != 200)
      throw TadaApiException(message: 'Room list error ${response.statusCode}');
    final List rooms = response.data['result'];
    return List.from(
      <Room>[
        for (var i = 0; i < rooms.length; i += 1) Room.fromJson(rooms[i]),
      ],
    );
  }
}
