import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/core/common/snackbar/my_snackbar.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/deleteArtworkByIdUsecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artworks_by_userId.dart';
import 'package:tryproject/features/artwork/domain/use_case/update_artwork_usecase.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
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
  final ArtworkBloc _artworkBloc;
  final UpdateArtworkUsecase _updateArtworkUsecase;

  ProfileBloc({
    required ArtworkBloc artwork_bloc,
    required GetArtworksByUseridUsecase getArtworksByUseridUsecase,
    required ArtworkCrudBloc artworkCrudBloc,
    required GetArtworkByIdUsecase getArtworkByIdUsecase,
    required GetPurchasesByUserIdUsecase getPurchasesByUserIdUsecase,
    required DeleteArtworkByIdUseCase deleteArtworkByIdUseCase,
    required GetSavedCollectionUsecase getSavedCollectionUsecase,
    required UpdateArtworkUsecase updateArtworkUsecase,
  })  : _getPurchasesByUserIdUsecase = getPurchasesByUserIdUsecase,
        _artworkCrudBloc = artworkCrudBloc,
        _getArtworksByUseridUsecase = getArtworksByUseridUsecase,
        _getArtworkByIdUsecase = getArtworkByIdUsecase,
        _deleteArtworkByIdUseCase = deleteArtworkByIdUseCase,
        _getSavedCollectionUsecase = getSavedCollectionUsecase,
        _updateArtworkUsecase = updateArtworkUsecase,
        _artworkBloc = artwork_bloc,
        super(ProfileState.initial()) {
    on<FetchPurchasesByUserId>(_onFetchPurchasesByUserId);
    on<GetCollection>(_onGetCollection);
    on<UpdateArtworkEvent>(_onUpdateArtworkEvent);

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

    on<NavigateToEdit>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                  providers: [BlocProvider.value(value: _artworkCrudBloc)],
                  child: event.destination)));
    });

    on<NavigateToDetailView>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _artworkBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );
  }

  void _onUpdateArtworkEvent(
    UpdateArtworkEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Log the data being sent to the backend
    print('Updating Artwork with:');
    print('Title: ${event.title}');
    print('Price: ${event.price}');
    print('Medium: ${event.mediumUsed}');
    print('Categories: ${event.categories}');
    print('Creators Note: ${event.creatorsNote}');
    print('Images: ${event.images}');

    // Call the usecase
    final result = await _updateArtworkUsecase.call(UpdateArtworkParams(
      artworkId: event.artworkId,
      title: event.title,
      dimensions: event.dimensions,
      price: event.price,
      mediumUsed: event.mediumUsed,
      categories: event.categories,
      creatorsNote: event.creatorsNote,
      images: event.images,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
            context: event.context, message: "Artwork update failed");
      },
      (artworkEntity) {
        // Update the selectedArtwork with the new artworkEntity
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          selectedArtwork: artworkEntity, // Add this line
        ));
        showMySnackBar(
            context: event.context, message: "Artwork updated successfully!");
      },
    );
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
        if (failure.message.contains("No saved artworks found")) {
          emit(state.copyWith(isLoading: false, collection: []));
        } else {
          emit(state.copyWith(
              isLoading: false, collection: [], errorMessage: failure.message));
        }
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
