import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artworks_by_userId.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/use_case/GetUserByIdUseCase.dart';
import 'package:tryproject/features/auth/domain/use_case/get_artists_usecase.dart';

// import 'package:tryproject/features/auth/domain/use_case/getartists_usecase.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final GetartistsUsecase _getartistsUsecase;
  final GetUserByIdUsecase _getUserByIdUsecase;
  final GetArtworksByUseridUsecase _getArtworksByUseridUsecase;

  ArtistBloc({
    required GetartistsUsecase getartistsUsecase,
    required GetUserByIdUsecase getUserByIdUsecase,
    required GetArtworksByUseridUsecase getArtworksByUseridUsecase,
  })  : _getartistsUsecase = getartistsUsecase,
        _getUserByIdUsecase = getUserByIdUsecase,
        _getArtworksByUseridUsecase = getArtworksByUseridUsecase,
        super(ArtistState.initial()) {
    on<FetchAllArtists>(_onFetchAllArtists);
    on<FetchUserById>(_onFetchUserById);
    on<FetchArtworksByUserId>(_onFetchArtworksByUserId);
  }

  Future<void> _onFetchAllArtists(
      FetchAllArtists event, Emitter<ArtistState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getartistsUsecase.call();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (artists) => emit(state.copyWith(
        isLoading: false,
        artists: artists,
      )),
    );
  }

  Future<void> _onFetchUserById(
      FetchUserById event, Emitter<ArtistState> emit) async {
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

  Future<void> _onFetchArtworksByUserId(
      FetchArtworksByUserId event, Emitter<ArtistState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getArtworksByUseridUsecase.call(event.userId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (artworks) => emit(state.copyWith(
        isLoading: false,
        artworks: artworks,
      )),
    );
  }
}
