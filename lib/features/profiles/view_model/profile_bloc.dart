import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/deleteArtworkByIdUsecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artworks_by_userId.dart';
import 'package:tryproject/features/profiles/view_model/upload_edit/artwork_crud_bloc.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/purchases/domain/use_case/GetPurchasesByUserIdUsecase.dart';
import 'package:tryproject/features/saved_artwork/domain/entity/save_artwork_entity.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/fetch_saved_artwork_by_userid.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetPurchasesByUserIdUsecase _getPurchasesByUserIdUsecase;
  final ArtworkCrudBloc _artworkCrudBloc;
  final GetArtworksByUseridUsecase _getArtworksByUseridUsecase;
  final GetArtworkByIdUsecase _getArtworkByIdUsecase;
  final DeleteArtworkByIdUseCase _deleteArtworkByIdUseCase;
  final GetSavedCollectionUsecase _getSavedCollectionUsecase;

  ProfileBloc({
    required GetArtworksByUseridUsecase getArtworksByUseridUsecase,
    required ArtworkCrudBloc artworkCrudBloc,
    required GetArtworkByIdUsecase getArtworkByIdUsecase,
    required GetPurchasesByUserIdUsecase getPurchasesByUserIdUsecase,
    required DeleteArtworkByIdUseCase deleteArtworkByIdUseCase,
    required GetSavedCollectionUsecase getSavedCollectionUsecase,
  })  : _getPurchasesByUserIdUsecase = getPurchasesByUserIdUsecase,
        _artworkCrudBloc = artworkCrudBloc,
        _getArtworksByUseridUsecase = getArtworksByUseridUsecase,
        _getArtworkByIdUsecase = getArtworkByIdUsecase,
        _deleteArtworkByIdUseCase = deleteArtworkByIdUseCase,
        _getSavedCollectionUsecase = getSavedCollectionUsecase,
        super(ProfileState.initial()) {
    on<FetchPurchasesByUserId>(_onFetchPurchasesByUserId);
    on<GetCollection>(_onGetCollection);

    on<FetchArtworkByUserID>(_onFetchArtworksByUserId);
    on<FetchArtworkById>(_onFetchArtworkById);
    on<DeleteArtworkById>(_onDeleteArtworkById);

    on<NavigateToUpload>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                  providers: [BlocProvider.value(value: _artworkCrudBloc)],
                  child: event.destination)));
    });
  }
  Future<void> _onFetchArtworksByUserId(
    FetchArtworkByUserID event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getArtworksByUseridUsecase.call(event.userId);
    result.fold((failure) {
      print("api: ${failure.message}");
      emit(state.copyWith(
          isLoading: false, artworks: [], errorMessage: failure.message));
    }, (artworks) {
      emit(state.copyWith(isLoading: false, artworks: artworks));
    });
  }

  Future<void> _onGetCollection(
    GetCollection event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getSavedCollectionUsecase.call(event.buyerId);
    result.fold(
      (failure) {
        print("API Error: ${failure.message}");

        emit(state.copyWith(
            isLoading: false, collection: [], errorMessage: failure.message));
      },
      (collection) {
        emit(state.copyWith(isLoading: false, collection: collection));
      },
    );
  }

  // Fetch purchases by user ID
  Future<void> _onFetchPurchasesByUserId(
    FetchPurchasesByUserId event,
    Emitter<ProfileState> emit,
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

  Future<void> _onFetchArtworkById(
      FetchArtworkById event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    final Either<Failure, ArtworkEntity> result =
        await _getArtworkByIdUsecase.call(event.id);
    result.fold(
        (failure) => emit(
            state.copyWith(isLoading: false, errorMessage: failure.message)),
        (artwork) =>
            emit(state.copyWith(isLoading: false, selectedArtwork: artwork)));
  }

  Future<void> _onDeleteArtworkById(
    DeleteArtworkById event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _deleteArtworkByIdUseCase.call(event.artworkId);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (_) {
        // Remove deleted artwork from the state
        final updatedArtworks = state.artworks
            .where((artwork) => artwork.artworkId != event.artworkId)
            .toList();
        emit(state.copyWith(isLoading: false, artworks: updatedArtworks));
      },
    );
  }
}
