// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteMovieEntityAdapter extends TypeAdapter<FavoriteMovieEntity> {
  @override
  final int typeId = 0;

  @override
  FavoriteMovieEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteMovieEntity(
      name: fields[0] as String,
      posterPath: fields[1] as String,
      backDropPath: fields[2] as String,
      id: fields[3] as int,
      mediaType: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteMovieEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.posterPath)
      ..writeByte(2)
      ..write(obj.backDropPath)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.mediaType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteMovieEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
