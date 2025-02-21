import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_all_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';

part 'artwork_event.dart';
part 'artwork_state.dart';

class ArtworkBloc extends Bloc<ArtworkEvent, ArtworkState> {
  final GetAllArtworkUsecase _getAllArtworkUsecase;
  final GetArtworkByIdUsecase _getArtworkByIdUsecase;

  ArtworkBloc({
    required GetAllArtworkUsecase getAllArtworkUsecase,
    required GetArtworkByIdUsecase getArtworkByIdUsecase,
  })  : _getAllArtworkUsecase = getAllArtworkUsecase,
        _getArtworkByIdUsecase = getArtworkByIdUsecase,
        super(ArtworkState.initial()) {
    on<FetchAllArtworks>(_onFetchAllArtworks);
    on<FetchArtworkById>(_onFetchArtworkById);

    add(FetchAllArtworks());

    on<NavigateToArtworkDetail>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => event.destination,
          ),
        );
      },
    );
  }

  Future<void> _onFetchAllArtworks(
      FetchAllArtworks event, Emitter<ArtworkState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllArtworkUsecase.call();
    result.fold(
        (failure) => emit(
            state.copyWith(isLoading: false, errorMessage: failure.message)),
        (artworks) =>
            emit(state.copyWith(isLoading: false, artworks: artworks)));
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
