import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/purchases/domain/use_case/create_purchase_usecase.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final CreatePurchaseUsecase _createPurchaseUsecase;
  final GetArtworkByIdUsecase _getArtworkByIdUsecase;

  PurchaseBloc({
    required CreatePurchaseUsecase createPurchaseUsecase,
    required GetArtworkByIdUsecase getArtworkByIdUsecase,
  })  : _createPurchaseUsecase = createPurchaseUsecase,
        _getArtworkByIdUsecase = getArtworkByIdUsecase,
        super(PurchaseState.initial()) {
    on<CreatePurchaseEvent>(_onCreatePurchase);
    // on<FetchArtworkById>(_onFetchArtworkById);
  }

  // Fetch artwork details when the event is triggered
  void _onFetchArtworkById(
    FetchArtworkById event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getArtworkByIdUsecase.call(event.id);

    result.fold(
      (failure) => emit(
        state.copyWith(
            isLoading: false,
            artworkTitle: null,
            artworkPrice: null,
            artworkImages: null),
      ),
      (artwork) {
        emit(state.copyWith(
          isLoading: false,
          artworkTitle: artwork.title,
          artworkPrice: double.tryParse(artwork.price),
          artworkImages: artwork.images != null
              ? [artwork.images!]
              : null, // assuming `images` is a single image URL or path
        ));
      },
    );
  }

  void _onCreatePurchase(
    CreatePurchaseEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _createPurchaseUsecase.call(CreatePurchaseUserParams(
      art_id: event.art_id,
      buyer_id: event.buyer_id,
      address: event.address,
      status: "Order Confirmed",
    ));

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (purchaseId) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          purchaseId: purchaseId,
          isOtpSent: true,
        ));
      },
    );
  }
}
