import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/core/common/snackbar/my_snackbar.dart';
import 'package:tryproject/features/artwork/domain/use_case/create_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/update_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/upload_artwork_image_usecase.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/use_case/update_profile_usecase.dart';
import 'package:tryproject/features/auth/domain/use_case/upload_image.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class ArtworkCrudBloc extends Bloc<ArtworkCrudEvent, ArtworkCrudState> {
  final CreateArtworkUsecase _createArtworkUsecase;
  final UploadArtworkUsecase _uploadArtworkImageUsecase;
  final UpdateArtworkUsecase _updateArtworkUsecase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  ArtworkCrudBloc({
    required UploadImageUsecase uploadImageUsecase,
    required UpdateProfileUseCase updateProfileUseCase,
    required UploadArtworkUsecase uploadArtworkimageusecase,
    required CreateArtworkUsecase createArtworkUsecase,
    required UpdateArtworkUsecase updateArtworkUsecase,
  })  : _createArtworkUsecase = createArtworkUsecase,
        _uploadArtworkImageUsecase = uploadArtworkimageusecase,
        _updateArtworkUsecase = updateArtworkUsecase,
        _updateProfileUseCase = updateProfileUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(const ArtworkCrudState.initial()) {
    on<CreateArtworkEvent>(_onCreateArtworkEvent);
    on<LoadImage>(_onLoadArtImage);
    on<UpdateArtworkEvent>(_onUpdateArtworkEvent);
    on<UpdateUserProfile>(_onUpdateProfileEvent);
    on<UploadProfileImage>(_onUploadProfileImage);
  }

  Future<void> _onUploadProfileImage(
    UploadProfileImage event,
    Emitter<ArtworkCrudState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result =
        await _uploadImageUsecase.call(uploadImageParams(file: event.file));

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (imageName) =>
          emit(state.copyWith(isLoading: false, uploadedImageName: imageName)),
    );
  }

  Future<void> _onUpdateProfileEvent(
    UpdateUserProfile event,
    Emitter<ArtworkCrudState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _updateProfileUseCase.call(UpdateProfileParams(
      userId: event.userId,
      fullName: event.fullName,
      email: event.email ?? '',
      contactNo: event.contactNo,
      profilePic: event.profilePic,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
        showMySnackBar(
          context: event.context,
          message: "Profile update failed",
        );
      },
      (updatedUser) {
        emit(state.copyWith(
          isLoading: false,
          selectedUser: updatedUser,
          isSuccess: true,
        ));
        showMySnackBar(
          context: event.context,
          message: "Profile updated successfully!",
        );
      },
    );
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
