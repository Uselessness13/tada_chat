import 'dart:convert';

class ServerSettings {
    ServerSettings({
        required this.maxMessageLength,
        required this.maxRoomTitleLength,
        required this.maxUsernameLength,
        required this.uptime,
    });

    final int maxMessageLength;
    final int maxRoomTitleLength;
    final int maxUsernameLength;
    final int uptime;

    factory ServerSettings.fromRawJson(String str) => ServerSettings.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ServerSettings.fromJson(Map<String, dynamic> json) => ServerSettings(
        maxMessageLength: json["max_message_length"],
        maxRoomTitleLength: json["max_room_title_length"],
        maxUsernameLength: json["max_username_length"],
        uptime: json["uptime"],
    );

    Map<String, dynamic> toJson() => {
        "max_message_length": maxMessageLength,
        "max_room_title_length": maxRoomTitleLength,
        "max_username_length": maxUsernameLength,
        "uptime": uptime,
    };
}
