part of 'purchase_bloc.dart';

sealed class PurchaseEvent extends Equatable {
  const PurchaseEvent();
  @override
  List<Object> get props => [];
}

class CreatePurchaseEvent extends PurchaseEvent {
  final BuildContext context;
  final String art_id;
  final String buyer_id;
  final String address;
  final String status;
  final String? otp;
  final DateTime? otp_expiration;
  final DateTime? orderDate;
  final String? totalAmount;
  final String? purchaseId;

  const CreatePurchaseEvent({
    required this.context,
    required this.art_id,
    required this.buyer_id,
    required this.address,
    required this.status,
    this.otp,
    this.otp_expiration,
    this.orderDate,
    this.totalAmount,
    this.purchaseId,
  });

  @override
  List<Object> get props => [art_id, buyer_id, address];
}

class FetchPurchasesByUserId extends PurchaseEvent {
  final String userId;

  const FetchPurchasesByUserId({required this.userId});

  @override
  List<Object> get props => [userId];
}

class FetchArtworkById extends PurchaseEvent {
  final String id;

  const FetchArtworkById({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchArtistSales extends PurchaseEvent {
  final String artistId;

  const FetchArtistSales({required this.artistId});

  @override
  List<Object> get props => [artistId];
}
