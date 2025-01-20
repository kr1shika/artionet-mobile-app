import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/core/common/snackbar/my_snackbar.dart';
import 'package:tryproject/features/auth/domain/use_case/login_usecase.dart';
import 'package:tryproject/features/home/presentation/view/buyer/homeview.dart';
import 'package:tryproject/features/home/presentation/view_model/home_cubit.dart';

part 'artist_login_event.dart';
part 'artist_login_state.dart';

class ArtistLoginBloc extends Bloc<ArtistLoginEvent, ArtistLoginState> {
  // final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUseCase _loginUseCase;

  ArtistLoginBloc({
    // required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
  })  :
        //  _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        super(ArtistLoginState.initial()) {
    // on<NavigateRegisterScreenEvent>(
    //   (event, emit) {
    //     Navigator.push(
    //       event.context,
    //       MaterialPageRoute(
    //         builder: (context) => MultiBlocProvider(
    //           providers: [
    //             BlocProvider.value(value: _registerBloc),
    //           ],
    //           child: event.destination,
    //         ),
    //       ),
    //     );
    //   },
    // );

    on<NavigateHomeScreenEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _homeCubit,
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<LoginUserEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _loginUseCase(
          LoginParams(
            email: event.email,
            password: event.password,
          ),
        );
        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: "Invalid Credentials",
              color: Colors.red,
            );
          },
          (token) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            // final prefs=await SharedPreferences.getInstance();
            // await prefs.setString('email',user.email);
            add(
              NavigateHomeScreenEvent(
                context: event.context,
                destination: const HomeView(),
              ),
            );
            // _homeCubit.setToken(token);
          },
        );
      },
    );
  }
}
