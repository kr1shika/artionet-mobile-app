import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_all_artwork_usecase.dart';

part 'artwork_event.dart';
part 'artwork_state.dart';

class ArtworkBloc extends Bloc<ArtworkEvent, ArtworkState> {
  final GetAllArtworkUsecase _getAllArtworkUsecase;

  ArtworkBloc({required GetAllArtworkUsecase getAllArtworkUsecase})
      : _getAllArtworkUsecase = getAllArtworkUsecase,
        super(ArtworkState.initial()) {
    on<FetchAllArtworks>(_onFetchAllArtworks);
    add(FetchAllArtworks());
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
    return null;
  }

  // ArtworkBloc({required this.getAllArtworkUsecase}) : super(ArtworkState.initial()) {
  //   on<FetchAllArtworks>(_onFetchAllArtworks);
  // }

  // void _onFetchAllArtworks(FetchAllArtworks event, Emitter<ArtworkState> emit) async {
  //   emit(state.copyWith(isLoading: true));

  //   final result = await getAllArtworkUsecase.call();

  //   result.fold(
  //     (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
  //     (artworks) => emit(state.copyWith(isLoading: false, artworks: artworks)),

  //   );
  // }
}
