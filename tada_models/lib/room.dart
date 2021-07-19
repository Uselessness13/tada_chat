import 'dart:convert';

import 'server_message.dart';

class Room {
  Room({
    required this.name,
    required this.lastMessage,
  });

  final String name;
  final ServerMessage? lastMessage;

  factory Room.fromRawJson(String str) => Room.fromJson(json.decode(str));

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        name: json["name"] == null ? null : json["name"],
        lastMessage: json["last_message"] == null
            ? null
            : ServerMessage.fromJson(json["last_message"]),
      );
}
