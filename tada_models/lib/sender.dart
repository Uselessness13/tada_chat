import 'dart:convert';

class Sender {
  Sender({
    required this.username,
  });

  final String username;

  factory Sender.fromRawJson(String str) => Sender.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
