import 'package:tada_local_storage/constants.dart';
import 'package:tada_local_storage/username_box_provider.dart';

class TadaLocalStorageHelper {
  late UsernameBoxProvider _usernameBoxProvider;

  init() async {
    _usernameBoxProvider = UsernameBoxProvider(Constants.USERNAME);
    await _usernameBoxProvider.openBox();
  }

  String get userName => _usernameBoxProvider.read();
  setUsername(String username) => _usernameBoxProvider.save(username);
}
