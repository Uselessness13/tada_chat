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
  final String? room;
  @HiveField(2)
  final DateTime? created;
  @HiveField(3)
  final Sender? sender;
  @HiveField(4)
  final String? text;

  factory Message.fromRawJson(String str) =>
      Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? null : json["id"],
        room: json["room"] == null ? null : json["room"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "room": room == null ? null : room,
        "created": created == null ? null : created?.toIso8601String(),
        "sender": sender == null ? null : sender?.toJson(),
        "text": text == null ? null : text,
      };
}
