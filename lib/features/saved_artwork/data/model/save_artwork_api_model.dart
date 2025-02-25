import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tryproject/features/saved_artwork/domain/entity/save_artwork_entity.dart';

@JsonSerializable()
class SaveArtworkApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? savedId;
  final String art_id;
  final String buyer_id;
  final String status;
  final String? title;
  final String? imageUrl;

  const SaveArtworkApiModel({
    this.savedId,
    required this.art_id,
    required this.buyer_id,
    this.title,
    this.imageUrl,
    required this.status,
  });

  factory SaveArtworkApiModel.fromJson(Map<String, dynamic> json) {
    String? imageUrl = json['imageUrl'];
    if (imageUrl != null && !imageUrl.startsWith('http')) {
      imageUrl = 'http://10.0.2.2:5055/$imageUrl';
    }
    return SaveArtworkApiModel(
      art_id: json['art_id'],
      buyer_id: json['buyer_id'],
      status: json['status'],
      imageUrl: imageUrl,
      savedId: json['savedId'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'art_id': art_id,
      'buyer_id': buyer_id,
      'status': status,
      'imageUrl': imageUrl,
    };
  }

  SaveArtworkEntity toEntity() => SaveArtworkEntity(
      art_id: art_id,
      buyer_id: buyer_id,
      status: status,
      imageUrl: imageUrl,
      title: title,
      savedId: savedId);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [art_id, buyer_id, status, title, imageUrl, savedId];
}
