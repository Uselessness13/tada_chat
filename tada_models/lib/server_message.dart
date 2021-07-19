import 'dart:convert';

import 'sender.dart';

class ServerMessage {
  ServerMessage({
    required this.id,
    required this.room,
    required this.created,
    required this.sender,
    required this.text,
  });

  final String? id;
  final String? room;
  final DateTime? created;
  final Sender? sender;
  final String? text;

  factory ServerMessage.fromRawJson(String str) =>
      ServerMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServerMessage.fromJson(Map<String, dynamic> json) => ServerMessage(
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
