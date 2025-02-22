part of 'purchase_bloc.dart';

sealed class PurchaseEvent extends Equatable {
  const PurchaseEvent();

  @override
  List<Object?> get props => [];
}

class CreatePurchaseEvent extends PurchaseEvent {
  final String artId;
  final String buyerId;
  final String address;
  final String phoneNumber;
  final String purchaseId;

  const CreatePurchaseEvent({
    required this.artId,
    required this.buyerId,
    required this.address,
    required this.phoneNumber,
    required this.purchaseId,
  });

  @override
  List<Object?> get props => [artId, buyerId, address, phoneNumber, purchaseId];
}

class VerifyPurchaseEvent extends PurchaseEvent {
  final String purchaseId;
  final String otp;

  const VerifyPurchaseEvent({required this.purchaseId, required this.otp});

  @override
  List<Object?> get props => [purchaseId, otp];
}
