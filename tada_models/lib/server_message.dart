import 'dart:convert';

import 'package:tada_models/message.dart';
import 'package:tada_models/sender.dart';

class ServerMessage extends Message {
  ServerMessage({
    required this.id,
    required this.room,
    required this.created,
    required this.sender,
    required this.text,
  }) : super(id: id, room: room, text: text);

  final String id;
  final String room;
  final DateTime created;
  final Sender sender;
  final String text;

  factory ServerMessage.fromRawJson(String str) =>
      ServerMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServerMessage.fromJson(Map<String, dynamic> json) => ServerMessage(
        id: json["id"],
        room: json["room"],
        created: DateTime.parse(json["created"]),
        sender: Sender.fromJson(json["sender"]),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room": room,
        "created": created.toIso8601String(),
        "sender": sender.toJson(),
        "text": text,
      };
}
