import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/core/common/snackbar/my_snackbar.dart';
import 'package:tryproject/features/artwork/domain/use_case/create_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/update_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/upload_artwork_image_usecase.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class ArtworkCrudBloc extends Bloc<ArtworkCrudEvent, ArtworkCrudState> {
  final CreateArtworkUsecase _createArtworkUsecase;
  final UploadArtworkUsecase _uploadArtworkImageUsecase;
  final UpdateArtworkUsecase _updateArtworkUsecase;

  ArtworkCrudBloc({
    required UploadArtworkUsecase uploadArtworkimageusecase,
    required CreateArtworkUsecase createArtworkUsecase,
    required UpdateArtworkUsecase updateArtworkUsecase,
  })  : _createArtworkUsecase = createArtworkUsecase,
        _uploadArtworkImageUsecase = uploadArtworkimageusecase,
        _updateArtworkUsecase = updateArtworkUsecase,
        super(const ArtworkCrudState.initial()) {
    on<CreateArtworkEvent>(_onCreateArtworkEvent);
    on<LoadImage>(_onLoadArtImage);
    on<UpdateArtworkEvent>(_onUpdateArtworkEvent);
  }

  void _onLoadArtImage(LoadImage event, Emitter<ArtworkCrudState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadArtworkImageUsecase.call(
      uploadArtworkImageParams(
        file: event.file,
      ),
    );
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }

  void _onCreateArtworkEvent(
    CreateArtworkEvent event,
    Emitter<ArtworkCrudState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Call the usecase
    final result = await _createArtworkUsecase.call(CreateArtworkParams(
      title: event.title,
      dimensions: event.dimensions,
      price: event.price,
      medium_used: event.mediumUsed,
      artistId: event.artistId,
      categories: event.categories,
      creatorsNote: event.creatorsNote,
      images: event.images,
    ));

    // Handle the result
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
            context: event.context, message: "Artwork creation failed");
      },
      (artworkEntity) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Artwork created successfully!");
      },
    );
  }

  void _onUpdateArtworkEvent(
    UpdateArtworkEvent event,
    Emitter<ArtworkCrudState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

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
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Artwork updated successfully!");
      },
    );
  }
}
