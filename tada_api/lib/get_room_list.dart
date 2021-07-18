import 'package:dio/dio.dart';
import 'package:tada_api/api_exception.dart';
import 'package:tada_api/constants.dart';
import 'package:tada_api/rest_helper.dart';
import 'package:tada_models/tada_models.dart';

import 'api_provider.dart';

class GetRoomListProvider implements ApiProvider<void, List<Message>> {
  Future<List<Message>> execute([_]) async {
    Response response = await RestHelper.internal().get(Constants.ROOMS);
    if (response.statusCode != 200)
      throw TadaApiException(
          message: 'Server settings error ${response.statusCode}');
    return [...response.data.forEach((mes) => Message.fromJson(mes))];
  }
}
