import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/purchases/domain/use_case/GetPurchasesByUserIdUsecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetPurchasesByUserIdUsecase _getPurchasesByUserIdUsecase;

  ProfileBloc({
    required GetPurchasesByUserIdUsecase getPurchasesByUserIdUsecase,
  })  : _getPurchasesByUserIdUsecase = getPurchasesByUserIdUsecase,
        super(ProfileState.initial()) {
    on<FetchPurchasesByUserId>(_onFetchPurchasesByUserId);
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
