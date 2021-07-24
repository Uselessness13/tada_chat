import 'package:hive/hive.dart';
import 'message.dart';

part 'room.g.dart';

@HiveType(typeId: 1)
class Room {
  Room({required this.name, this.message});
  @HiveField(0)
  String name;

  @HiveField(1)
  Message? message;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        name: json["name"] == null ? null : json["name"],
        message: Message.fromJson(json["last_message"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "last_message": message?.toJson(),
      };
}
