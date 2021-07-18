import 'dart:convert';

class Message {
  Message({
    required this.room,
    required this.text,
    required this.id,
  });

  final String room;
  final String text;
  final String id;

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        room: json["room"],
        text: json["text"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "room": room,
        "text": text,
        "id": id,
      };
}
