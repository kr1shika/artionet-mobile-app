import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_all_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/search_artwork_usecase.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/use_case/GetUserByIdUseCase.dart';
import 'package:tryproject/features/auth/presentation/view_model/artist/artist_bloc.dart';
import 'package:tryproject/features/purchases/presentation/view_model/purchase_bloc.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/check_artwork_status_usecase.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/remove_saved_artwork_usecase.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/save_artwork_usecase.dart';

part 'artwork_event.dart';
part 'artwork_state.dart';

class ArtworkBloc extends Bloc<ArtworkEvent, ArtworkState> {
  final GetAllArtworkUsecase _getAllArtworkUsecase;
  final GetArtworkByIdUsecase _getArtworkByIdUsecase;
  final PurchaseBloc _purchaseBloc;
  final SaveArtworkUsecase _saveArtworkUsecase;
  final RemoveSavedArtworkUsecase _removeSavedArtworkUsecase;
  final CheckArtworkStatusUsecase _checkArtworkStatusUsecase;
  final SearchArtworksUsecase _searchArtworksUsecase;
  final GetUserByIdUsecase _getUserByIdUsecase;
  final ArtistBloc _artistBloc;

  ArtworkBloc({
    required PurchaseBloc purchaseBloc,
    required GetAllArtworkUsecase getAllArtworkUsecase,
    required GetArtworkByIdUsecase getArtworkByIdUsecase,
    required SaveArtworkUsecase saveArtworkUsecase,
    required SearchArtworksUsecase searchArtworksUsecase,
    required RemoveSavedArtworkUsecase removeSavedArtworkUsecase,
    required CheckArtworkStatusUsecase checkArtworkStatusUsecase,
    required ArtistBloc artistBloc,
    required GetUserByIdUsecase getUserByIdUsecase,
  })  : _getAllArtworkUsecase = getAllArtworkUsecase,
        _getArtworkByIdUsecase = getArtworkByIdUsecase,
        _purchaseBloc = purchaseBloc,
        _saveArtworkUsecase = saveArtworkUsecase,
        _removeSavedArtworkUsecase = removeSavedArtworkUsecase,
        _checkArtworkStatusUsecase = checkArtworkStatusUsecase,
        _searchArtworksUsecase = searchArtworksUsecase,
        _getUserByIdUsecase = getUserByIdUsecase,
        _artistBloc = artistBloc,
        super(ArtworkState.initial()) {
    on<FetchUserById>(_onFetchUserById);

    on<FetchAllArtworks>(_onFetchAllArtworks);
    on<FetchArtworkById>(_onFetchArtworkById);
    on<SaveArtworkEvent>(_onSaveArtwork);
    on<SearchArtworksEvent>(_onSearchArtworks);

    on<RemoveSavedArtworkEvent>(_onRemoveSavedArtwork);
    on<CheckArtworkStatusEvent>(_onCheckArtworkStatus);

    add(FetchAllArtworks());

    on<NavigateToPurchase>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _purchaseBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<NavigateToArtists>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                    value: _artistBloc), // Pass existing instance
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    add(FetchAllArtworks());
  }

  Future<void> _onFetchUserById(
      FetchUserById event, Emitter<ArtworkState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getUserByIdUsecase.call(event.userId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        isLoading: false,
        selectedUser: user,
      )),
    );
  }

  Future<void> _onFetchAllArtworks(
      FetchAllArtworks event, Emitter<ArtworkState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllArtworkUsecase.call();

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (artworks) {
        print("Fetched Artworks: ${artworks.length}"); // Debugging log
        emit(state.copyWith(isLoading: false, artworks: artworks));
      },
    );
  }

  Future<void> _onSearchArtworks(
      SearchArtworksEvent event, Emitter<ArtworkState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _searchArtworksUsecase.call(event.query);

    result.fold(
      (failure) {
        // Check if API returned a 404 with "No matching artworks found."
        if (failure.message.contains("No matching artworks found")) {
          emit(state.copyWith(
              isLoading: false,
              artworks: [])); // Set empty list instead of error
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: failure.message));
        }
      },
      (artworks) => emit(state.copyWith(isLoading: false, artworks: artworks)),
    );
  }

  Future<void> _onCheckArtworkStatus(
      CheckArtworkStatusEvent event, Emitter<ArtworkState> emit) async {
    print(
        "Handling CheckArtworkStatusEvent for artId: ${event.artId}, buyerId: ${event.buyerId}");
    try {
      final isLiked = await checkArtworkStatus(
        artId: event.artId,
        buyerId: event.buyerId,
      );
      print("Artwork like status: $isLiked");
      emit(state.copyWith(likedStatuses: {
        ...state.likedStatuses,
        event.artId: isLiked,
      }));
    } catch (e) {
      print("Bloc Error: $e");
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<bool> checkArtworkStatus(
      {required String artId, required String buyerId}) async {
    try {
      final params = CheckArtworkStatusParams(artId: artId, buyerId: buyerId);
      final result = await _checkArtworkStatusUsecase.call(params);
      return result.fold(
        (failure) {
          print("Failed to check artwork status: ${failure.message}");
          return false; // Default to unliked if the API call fails
        },
        (isLiked) => isLiked,
      );
    } catch (e) {
      print("Error checking artwork status: $e");
      return false; // Default to unliked if an exception occurs
    }
  }

  Future<void> _onSaveArtwork(
      SaveArtworkEvent event, Emitter<ArtworkState> emit) async {
    final result = await _saveArtworkUsecase.call(SaveArtworkParams(
      artId: event.artId,
      buyerId: event.buyerId,
    ));

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {
        emit(state.copyWith(likedStatuses: {
          ...state.likedStatuses,
          event.artId: true,
        }));
      },
    );
  }

  Future<void> _onRemoveSavedArtwork(
      RemoveSavedArtworkEvent event, Emitter<ArtworkState> emit) async {
    final result =
        await _removeSavedArtworkUsecase.call(RemoveSavedArtworkParams(
      artId: event.artId,
      buyerId: event.buyerId,
    ));

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {
        // Update the likedStatuses map to reflect the unliked state
        emit(state.copyWith(likedStatuses: {
          ...state.likedStatuses,
          event.artId: false, // Set isLiked to false
        }));
      },
    );
  }

  Future<void> _onFetchArtworkById(
      FetchArtworkById event, Emitter<ArtworkState> emit) async {
    emit(state.copyWith(isLoading: true));
    final Either<Failure, ArtworkEntity> result =
        await _getArtworkByIdUsecase.call(event.id);
    result.fold(
        (failure) => emit(
            state.copyWith(isLoading: false, errorMessage: failure.message)),
        (artwork) =>
            emit(state.copyWith(isLoading: false, selectedArtwork: artwork)));
  }
}
