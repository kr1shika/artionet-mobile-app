import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/purchases/domain/use_case/create_purchase_usecase.dart';
import 'package:tryproject/features/purchases/domain/use_case/verify_purchase_usecase.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final CreatePurchaseUsecase _createPurchaseUsecase;
  final VerifyPurchaseUsecase _verifyPurchaseUsecase;

  PurchaseBloc({
    required CreatePurchaseUsecase createPurchaseUsecase,
    required VerifyPurchaseUsecase verifyPurchaseUsecase,
  })  : _createPurchaseUsecase = createPurchaseUsecase,
        _verifyPurchaseUsecase = verifyPurchaseUsecase,
        super(PurchaseState.initial()) {
    on<CreatePurchaseEvent>(_onCreatePurchase);
    on<VerifyPurchaseEvent>(_onVerifyPurchase);
  }

  void _onCreatePurchase(
    CreatePurchaseEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _createPurchaseUsecase.call(CreatePurchaseUserParams(
      art_id: event.artId,
      buyer_id: event.buyerId,
      address: event.address,
      status: "Pending",
      phone_number: event.phoneNumber,
    ));

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (_) => emit(state.copyWith(
          isLoading: false, isSuccess: true, purchaseId: event.purchaseId)),
    );
  }

  void _onVerifyPurchase(
    VerifyPurchaseEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _verifyPurchaseUsecase.call(
      VerifyPurchaseParams(purchaseId: event.purchaseId, otp: event.otp),
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }
}
