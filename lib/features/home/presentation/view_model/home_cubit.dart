import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/app/di/di.dart';
import 'package:tryproject/app/shared_prefs/token_shared_prefs.dart';
import 'package:tryproject/features/auth/presentation/view/buyers/login_view.dart';
import 'package:tryproject/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tryproject/features/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TokenSharedPrefs tokenSharedPrefs;

  HomeCubit(this.tokenSharedPrefs) : super(HomeState.initial());

  Future<void> loadUserId() async {
    final userId = tokenSharedPrefs.getUserId();
    emit(state.copyWith(userId: userId));
  }

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void logout(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: const LoginView(),
            ),
          ),
        );
      }
    });
  }
}
