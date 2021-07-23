// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerSettingsAdapter extends TypeAdapter<ServerSettings> {
  @override
  final int typeId = 4;

  @override
  ServerSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerSettings(
      maxMessageLength: fields[0] as int,
      maxRoomTitleLength: fields[1] as int,
      maxUsernameLength: fields[2] as int,
      uptime: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ServerSettings obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.maxMessageLength)
      ..writeByte(1)
      ..write(obj.maxRoomTitleLength)
      ..writeByte(2)
      ..write(obj.maxUsernameLength)
      ..writeByte(3)
      ..write(obj.uptime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
