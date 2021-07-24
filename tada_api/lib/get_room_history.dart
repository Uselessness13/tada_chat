import 'package:dio/dio.dart';
import 'package:tada_api/api_exception.dart';
import 'package:tada_api/constants.dart';
import 'package:tada_api/rest_helper.dart';
import 'package:tada_local_storage/models/message.dart';

import 'api_provider.dart';

class GetRoomHistoryProvider implements ApiProvider<String, List<Message>> {
  Future<List<Message>> execute([String? name]) async {
    try {
      Response response = await RestHelper.internal()
          .get('${Constants.ROOMS}/$name${Constants.HISTORY}');
      if (response.statusCode != 200)
        throw TadaApiException(
            message: 'Server settings error ${response.statusCode}');
      final List messages = response.data['result'];
      return List.from(
        <Message>[
          for (var i = 0; i < messages.length; i += 1)
            Message.fromJson(messages[i]),
        ],
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.response)
        throw TadaApiNotFoundException();
      else
        throw TadaApiException(message: e.message);
    }
  }
}
