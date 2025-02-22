import 'package:json_annotation/json_annotation.dart';

part 'purchase_with_artwork_dto.g.dart';

@JsonSerializable()
class PurchaseWithArtworkDTO {
  final String purchaseId;
  final String artId;
  final String? title;
  final String? imageUrl; // Just a string for image URL
  final String status;
  final DateTime orderDate;
  final int totalAmount;
  final String address;

  PurchaseWithArtworkDTO({
    required this.purchaseId,
    required this.artId,
     this.title,
     this.imageUrl,
    required this.status,
    required this.orderDate,
    required this.totalAmount,
    required this.address,
  });

  factory PurchaseWithArtworkDTO.fromJson(Map<String, dynamic> json) =>
      _$PurchaseWithArtworkDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseWithArtworkDTOToJson(this);
}
