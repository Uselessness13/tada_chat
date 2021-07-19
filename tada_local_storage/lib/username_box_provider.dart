import 'package:tada_local_storage/boxProvider.dart';

class UsernameBoxProvider extends BoxProvider<String> {
  UsernameBoxProvider(String name) : super(name) {
    openBox();
  }

  @override
  String read() => box.get(name);

  @override
  save(String t) => box.put(name, t);
}
