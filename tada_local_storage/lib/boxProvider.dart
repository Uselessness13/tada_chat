import 'package:hive/hive.dart';

abstract class BoxProvider<T> {
  final String name;
  late Box _box;
  Box get box => _box;
  BoxProvider(this.name);

  openBox() async {
    _box = await Hive.openBox<T>(name);
  }

  save(T t);
  T read();
  clear() => _box.clear();
  close() => _box.close();
}
