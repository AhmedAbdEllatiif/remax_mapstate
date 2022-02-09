// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_project_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavProjectTableAdapter extends TypeAdapter<FavProjectTable> {
  @override
  final int typeId = 0;

  @override
  FavProjectTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavProjectTable(
      id: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavProjectTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavProjectTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
