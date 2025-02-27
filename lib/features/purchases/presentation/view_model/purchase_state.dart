part of 'purchase_bloc.dart';

class PurchaseState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isOtpSent;
  final String? purchaseId;
  final String? artworkTitle;
  final double? artworkPrice;
  final List<String>? artworkImages; // To store image URLs or paths
  final List<PurchaseEntity>? purchases;
  final String? errorMessage;
  final List<PurchaseEntity>? artistSales;

  const PurchaseState({
    required this.isLoading,
    required this.isSuccess,
    required this.isOtpSent,
    this.purchaseId,
    this.artworkTitle,
    this.artworkPrice,
    this.artworkImages,
    this.purchases,
    this.errorMessage,
    this.artistSales,
  });

  factory PurchaseState.initial() {
    return const PurchaseState(
      isLoading: false,
      isSuccess: false,
      isOtpSent: false,
      purchaseId: null,
      artworkTitle: null,
      artworkPrice: null,
      artworkImages: null,
      purchases: [],
      artistSales: [],
      errorMessage: null,
    );
  }

  PurchaseState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isOtpSent,
    String? purchaseId,
    String? artworkTitle,
    double? artworkPrice,
    List<String>? artworkImages,
    List<PurchaseEntity>? purchases,
    List<PurchaseEntity>? artistSales,
    String? errorMessage,
  }) {
    return PurchaseState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isOtpSent: isOtpSent ?? this.isOtpSent,
      purchaseId: purchaseId ?? this.purchaseId,
      artworkTitle: artworkTitle ?? this.artworkTitle,
      artworkPrice: artworkPrice ?? this.artworkPrice,
      artworkImages: artworkImages ?? this.artworkImages,
      purchases: purchases ?? this.purchases,
      artistSales: artistSales ?? this.artistSales,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isOtpSent,
        purchaseId,
        artworkTitle,
        artworkPrice,
        artworkImages,
        purchases ?? [],
        artistSales ?? [],
        errorMessage ?? '',
      ];
}
