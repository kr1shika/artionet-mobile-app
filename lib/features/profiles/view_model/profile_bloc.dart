import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artworks_by_userId.dart';
import 'package:tryproject/features/profiles/view_model/upload_edit/artwork_crud_bloc.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/purchases/domain/use_case/GetPurchasesByUserIdUsecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetPurchasesByUserIdUsecase _getPurchasesByUserIdUsecase;
  final ArtworkCrudBloc _artworkCrudBloc;
  final GetArtworksByUseridUsecase _getArtworksByUseridUsecase;

  ProfileBloc({
    required GetArtworksByUseridUsecase getArtworksByUseridUsecase,
    required ArtworkCrudBloc artworkCrudBloc,
    required GetPurchasesByUserIdUsecase getPurchasesByUserIdUsecase,
  })  : _getPurchasesByUserIdUsecase = getPurchasesByUserIdUsecase,
        _artworkCrudBloc = artworkCrudBloc,
        _getArtworksByUseridUsecase = getArtworksByUseridUsecase,
        super(ProfileState.initial()) {
    on<FetchPurchasesByUserId>(_onFetchPurchasesByUserId);
    on<FetchArtworkByUserID>(_onFetchArtworksByUserId);

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
}
