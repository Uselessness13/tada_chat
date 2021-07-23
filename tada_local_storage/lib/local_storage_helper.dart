import 'package:hive_flutter/hive_flutter.dart';
import 'package:tada_local_storage/constants.dart';
import 'package:tada_local_storage/models/room.dart';
import 'package:tada_local_storage/models/sender.dart';
import 'package:tada_local_storage/models/message.dart';
import 'package:tada_local_storage/username_box_provider.dart';

class TadaLocalStorageHelper {
  late UsernameBoxProvider _usernameBoxProvider;

  init() async {
    Hive.registerAdapter<Room>(RoomAdapter());
    Hive.registerAdapter<Message>(ServerMessageAdapter());
    Hive.registerAdapter<Sender>(SenderAdapter());
    await Hive.openBox<Room>(Constants.ROOMS);
    await Hive.openBox<Message>(Constants.MESSAGES);
    _usernameBoxProvider = UsernameBoxProvider(Constants.USERNAME);
    await _usernameBoxProvider.openBox();
  }

  Box<Room> get roomsBox => Hive.box<Room>(Constants.ROOMS);
  Box<Message> get messagesBox =>
      Hive.box<Message>(Constants.MESSAGES);

  String get userName => _usernameBoxProvider.read();
  setUsername(String username) => _usernameBoxProvider.save(username);
}
