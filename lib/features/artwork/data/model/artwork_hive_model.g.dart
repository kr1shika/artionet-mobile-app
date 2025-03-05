// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtworkHiveModelAdapter extends TypeAdapter<ArtworkHiveModel> {
  @override
  final int typeId = 1;

  @override
  ArtworkHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArtworkHiveModel(
      id: fields[0] as String?,
      title: fields[1] as String?,
      dimensions: fields[2] as String,
      price: fields[3] as String,
      medium_used: fields[4] as String,
      images: fields[5] as String?,
      archive: fields[6] as String?,
      isLiked: fields[7] as bool?,
      artistId: fields[8] as String?,
      categories: fields[9] as String,
      creatorsNote: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ArtworkHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.dimensions)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.medium_used)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.archive)
      ..writeByte(7)
      ..write(obj.isLiked)
      ..writeByte(8)
      ..write(obj.artistId)
      ..writeByte(9)
      ..write(obj.categories)
      ..writeByte(10)
      ..write(obj.creatorsNote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtworkHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
