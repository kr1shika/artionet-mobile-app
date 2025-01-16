
// import 'package:equatable/equatable.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
// import 'package:uuid/uuid.dart';

// import '../../../../app/constants/hive_table_constant.dart';

// @HiveType(typeId: HiveTableConstant.artworkTableId)
// class ArtworkHiveModel extends Equatable{
//   @HiveField(0)
//   final String? artworkId;

//   @HiveField(1)
//   final String? artworkName;

//   ArtworkHiveModel({
//     String? artworkId,
//     required this.artworkName
//   }): artworkId=artworkId ?? const Uuid().v4();

//   const ArtworkHiveModel.initial(): artworkId='', artworkName='';

//   const ArtworkHiveModel.fromEntity(ArtworkEntity entity){
//     return ArtworkHiveModel(
//       artworkId: entity.artworkId,
//       artworkName: entity.artworkName,
//       );
//   }

//   ArtworkEntity toEntity(){
//     return ArtworkEntity(artworkName: artworkName, artworkId: artworkId);
//   }
  
//   @override
//   // TODO: implement props
//   List<Object?> get props => [artworkId, artworkName];

// }