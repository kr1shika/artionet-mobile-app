import 'package:equatable/equatable.dart';

class SaveArtworkEntity extends Equatable {
  final String? savedId;
  final String art_id;
  final String buyer_id;
  final String status;
  final String? imageUrl;
  final String? title;

  const SaveArtworkEntity(
      {required this.art_id,
      required this.buyer_id,
      required this.status,
      this.imageUrl,
      this.savedId,
      this.title});

  const SaveArtworkEntity.empty()
      : art_id = '',
        buyer_id = '',
        status = '',
        imageUrl = '',
        title = '',
        savedId = '';

  @override
  List<Object?> get props =>
      [art_id, buyer_id, status, imageUrl, title, savedId];
}
