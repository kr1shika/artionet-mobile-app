import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/core/common/snackbar/my_snackbar.dart';
import 'package:tryproject/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:tryproject/features/auth/presentation/view_model/login/login_bloc.dart';

part 'artist_register_event.dart';
part 'artist_register_state.dart';

class ArtistRegisterBloc
    extends Bloc<ArtistRegisterEvent, ArtistRegisterState> {
  final RegisterUseCase _registerUseCase;
  final LoginBloc _loginBloc;

  ArtistRegisterBloc({
    required LoginBloc loginBloc,
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        _loginBloc = loginBloc,
        super(ArtistRegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);

    on<NavigateScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _loginBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );
  }
  void _onRegisterEvent(
    RegisterUser event,
    Emitter<ArtistRegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      full_name: event.full_name,
      contact_no: event.contact_no,
      email: event.email,
      role: event.role,
      password: event.password,
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }
}
