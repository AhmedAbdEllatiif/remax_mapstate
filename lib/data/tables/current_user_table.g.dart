// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentUserTableAdapter extends TypeAdapter<CurrentUserTable> {
  @override
  final int typeId = 1;

  @override
  CurrentUserTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentUserTable(
      currentUser: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentUserTable obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.currentUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentUserTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
