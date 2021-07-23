import 'package:hive/hive.dart';

part 'sender.g.dart';

@HiveType(typeId: 3)
class Sender {
  Sender({required this.username});

  @HiveField(0)
  String username;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
