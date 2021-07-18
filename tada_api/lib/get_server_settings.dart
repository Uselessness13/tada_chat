import 'package:dio/dio.dart';
import 'package:tada_api/api_exception.dart';
import 'package:tada_api/constants.dart';
import 'package:tada_api/rest_helper.dart';
import 'package:tada_models/tada_models.dart';

import 'api_provider.dart';

class GetServerSettingsProvider implements ApiProvider<void, ServerSettings> {
  Future<ServerSettings> execute([_]) async {
    Response response = await RestHelper.internal().get(Constants.SETTINGS);
    if (response.statusCode != 200)
      throw TadaApiException(
          message: 'Server settings error ${response.statusCode}');
    return ServerSettings.fromJson(response.data);
  }
}
