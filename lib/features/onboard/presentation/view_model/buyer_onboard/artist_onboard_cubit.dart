import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/auth/presentation/view/artist/artist_signup_view.dart';
import 'package:tryproject/features/auth/presentation/view_model/artist_signup/artist_register_bloc.dart';

// Cubit for managing onboarding state
class OnboardingCubit extends Cubit<int> {
  final PageController pageController;

  OnboardingCubit(this.pageController) : super(0);

  void goToNextPage() {
    if (state < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(state + 1);
    }
  }

  void skipToLastPage(BuildContext context, ArtistRegisterBloc registerBloc) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: registerBloc,
          child: const ArtistSignupView(),
        ),
      ),
    );
  }

  void navigateToSignup(BuildContext context, ArtistRegisterBloc registerBloc) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: registerBloc,
          child: const ArtistSignupView(),
        ),
      ),
    );
  }
}
