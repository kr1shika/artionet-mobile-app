import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/onboard/presentation/view/onboard1.dart';
import 'package:tryproject/features/onboard/presentation/view_model/buyer_onboard/onboard_cubit.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(this._loginBloc) : super(null);

  final OnboardCubit _loginBloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 4510), () async {
      // Open Login page or Onboarding Screen

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _loginBloc,
              child: const OnboardScreens(),
            ),
          ),
        );
      }
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tryproject/features/auth/presentation/view/register_view.dart';
// import 'package:tryproject/features/auth/presentation/view_model/signup/register_bloc.dart';
// // import 'package:tryproject/features/onboard/presentation/view/onboard1.dart';
// // import 'package:tryproject/features/onboard/presentation/view_model/onboard_cubit.dart';

// class SplashCubit extends Cubit<void> {
//   SplashCubit(this._loginBloc) : super(null);

//   final RegisterBloc _loginBloc;

//   Future<void> init(BuildContext context) async {
//     await Future.delayed(const Duration(milliseconds: 4510), () async {
//       // Open Login page or Onboarding Screen

//       if (context.mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BlocProvider.value(
//               value: _loginBloc,
//               child: const RegisterView(),
//             ),
//           ),
//         );
//       }
//     });
//   }
// }
