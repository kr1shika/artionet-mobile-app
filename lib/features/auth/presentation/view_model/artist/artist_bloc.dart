import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/use_case/getartists_usecase.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final GetartistsUsecase _getartistsUsecase;

  ArtistBloc({
    required GetartistsUsecase getartistsUsecase,
  })  : _getartistsUsecase = getartistsUsecase,
        super(ArtistState.initial()) {
    on<FetchAllArtists>(_onFetchAllArtists);
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
}
