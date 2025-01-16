import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tryproject/features/auth/presentation/view/login_view.dart';
import 'package:tryproject/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tryproject/features/onboard/presentation/view_model/onboard_state.dart';

class OnboardCubit extends Cubit<OnboardState> {
  final PageController pageController;
  final LoginBloc loginBloc;

  OnboardCubit(this.pageController, this.loginBloc) : super(OnboardState(0));

  void goToNextPage() {
    if (state.currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(OnboardState(state.currentPage + 1));
    }
  }

  void skipOnboarding(BuildContext context) {
    loginBloc.add(NavigateRegisterScreenEvent(
        context: context, destination: LoginView()));
    // Navigator.pushNamed(context, '/login');
  }

  void onPageChanged(int index) {
    emit(OnboardState(index));
  }
}
