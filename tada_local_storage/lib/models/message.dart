import 'dart:convert';

import 'package:hive/hive.dart';
import 'sender.dart';

part 'message.g.dart';

@HiveType(typeId: 2)
class Message {
  Message({
    required this.id,
    required this.room,
    required this.created,
    required this.sender,
    required this.text,
  });
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String room;
  @HiveField(2)
  final DateTime created;
  @HiveField(3)
  final Sender sender;
  @HiveField(4)
  final String text;

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? null : json["id"],
        room: json["room"] == null ? null : json["room"],
        created: DateTime.parse(json["created"]),
        sender: Sender.fromJson(json["sender"]),
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "room": room,
        "created": created.toIso8601String(),
        "sender": sender.toJson(),
        "text": text,
      };
}
