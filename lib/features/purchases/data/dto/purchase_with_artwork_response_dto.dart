import 'package:json_annotation/json_annotation.dart';
import 'package:tryproject/features/purchases/data/model/purchase_api_model.dart';

part 'purchase_with_artwork_response_dto.g.dart';

@JsonSerializable()
class PurchaseWithArtworkResponseDTO {
  final bool success;
  final int count;
  final List<PurchaseApiModel> data;

  PurchaseWithArtworkResponseDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  factory PurchaseWithArtworkResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$PurchaseWithArtworkResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseWithArtworkResponseDTOToJson(this);
}
