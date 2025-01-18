import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/auth/presentation/view/buyers/register_view.dart';
import 'package:tryproject/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:tryproject/features/onboard/presentation/view_model/buyer_onboard/onboard_state.dart';

class OnboardCubit extends Cubit<OnboardState> {
  final PageController pageController;
  final RegisterBloc registerBloc;

  OnboardCubit(this.pageController, this.registerBloc) : super(OnboardState(0));

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
    registerBloc.add(NavigateScreenEvent(
        context: context, destination: const RegisterView()));
    // Navigator.pushNamed(context, '/login');
  }

  void onPageChanged(int index) {
    emit(OnboardState(index));
  }

  void navigateToRegisterview(BuildContext context, RegisterBloc registerBloc) {
  if (context.mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: registerBloc,
          child: const RegisterView(),
        ),
      ),
    );
  }
}

}
