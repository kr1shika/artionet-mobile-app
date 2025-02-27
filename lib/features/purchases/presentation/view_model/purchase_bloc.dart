import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/purchases/domain/use_case/GetPurchasesByUserIdUsecase.dart';
import 'package:tryproject/features/purchases/domain/use_case/create_purchase_usecase.dart';
import 'package:tryproject/features/purchases/domain/use_case/getArtist_sales_usecase.dart';
import 'package:tryproject/features/purchases/domain/use_case/update_status_usecase.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final CreatePurchaseUsecase _createPurchaseUsecase;
  final GetPurchasesByUserIdUsecase _getPurchasesByUserIdUsecase;
  final GetArtworkByIdUsecase _getArtworkByIdUsecase;
  final GetArtistSalesUsecase _getArtistSalesUsecase;
    final UpdatePurchaseStatusUseCase _updatePurchaseStatusUseCase;

  PurchaseBloc({
        required UpdatePurchaseStatusUseCase updatePurchaseStatusUseCase,

    required CreatePurchaseUsecase createPurchaseUsecase,
    required GetPurchasesByUserIdUsecase getPurchasesByUserIdUsecase,
    required GetArtworkByIdUsecase getArtworkByIdUsecase,
    required GetArtistSalesUsecase getArtistSalesUsecase,
  })  : _createPurchaseUsecase = createPurchaseUsecase,
        _getPurchasesByUserIdUsecase = getPurchasesByUserIdUsecase,
        _getArtworkByIdUsecase = getArtworkByIdUsecase,
        _getArtistSalesUsecase = getArtistSalesUsecase,
                _updatePurchaseStatusUseCase = updatePurchaseStatusUseCase,

        super(PurchaseState.initial()) {
    on<CreatePurchaseEvent>(_onCreatePurchase);
    on<FetchPurchasesByUserId>(_onFetchPurchasesByUserId);
    on<FetchArtworkById>(_onFetchArtworkById);
    on<FetchArtistSales>(_onFetchArtistSales);
        on<UpdatePurchaseStatusEvent>(_onUpdatePurchaseStatus);

  }

  // Fetch artist sales
  Future<void> _onFetchArtistSales(
    FetchArtistSales event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getArtistSalesUsecase.call(event.artistId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (sales) => emit(state.copyWith(isLoading: false, artistSales: sales)),
    );
  }

  // Fetch purchases by user ID
  Future<void> _onFetchPurchasesByUserId(
    FetchPurchasesByUserId event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getPurchasesByUserIdUsecase.call(event.userId);

    result.fold(
      (failure) {
        print("API Error: ${failure.message}");

        emit(state.copyWith(
            isLoading: false, purchases: [], errorMessage: failure.message));
      },
      (purchases) {
        emit(state.copyWith(isLoading: false, purchases: purchases));
      },
    );
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
          artworkImages: artwork.images != null ? [artwork.images!] : null,
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

    Future<void> _onUpdatePurchaseStatus(
    UpdatePurchaseStatusEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _updatePurchaseStatusUseCase.call(event.purchaseId, event.status);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }
}
