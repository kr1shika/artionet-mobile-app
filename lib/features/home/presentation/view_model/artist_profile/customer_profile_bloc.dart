import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:dartz/dartz.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/use_case/GetCurrentUserUseCase.dart';

part 'customer_profile_event.dart';
part 'customer_profile_state.dart';

class CustomerProfileBloc
    extends Bloc<CustomerProfileEvent, CustomerProfileState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;

  CustomerProfileBloc(this.getCurrentUserUseCase)
      : super(CustomerProfileInitial()) {
    on<FetchCustomerProfileEvent>((event, emit) async {
      emit(CustomerProfileLoading());
      final result = await getCurrentUserUseCase();

      result.fold(
        (failure) => emit(CustomerProfileError(failure.message)),
        (user) => emit(CustomerProfileLoaded(user)),
      );
    });
  }
}
