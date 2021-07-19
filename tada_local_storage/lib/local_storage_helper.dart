import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tada_local_storage/constants.dart';
import 'package:tada_local_storage/username_box_provider.dart';

class TadaLocalStorageHelper {
  late UsernameBoxProvider _usernameBoxProvider;

  TadaLocalStorageHelper() {
    getApplicationDocumentsDirectory().then((directory) {
      Hive.init(directory.path);
      _usernameBoxProvider = UsernameBoxProvider(Constants.USERNAME);
    });
  }

  String get userName => _usernameBoxProvider.read();
  setUsername(String username) => _usernameBoxProvider.save(username);
}
