part of 'purchase_bloc.dart';

class PurchaseState {
  final bool isLoading;
  final bool isSuccess;
  final String? purchaseId;

  PurchaseState({
    required this.isLoading,
    required this.isSuccess,
    this.purchaseId,
  });

  PurchaseState.initial()
      : isLoading = false,
        isSuccess = false,
        purchaseId = null;

  PurchaseState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? purchaseId,
  }) {
    return PurchaseState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      purchaseId: purchaseId ?? this.purchaseId,
    );
  }
}
