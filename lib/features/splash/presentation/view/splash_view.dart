import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/splash/presentation/view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // uture.delayed(const Duration(milliseconds: 4510), () {
    //   Navigator.pushReplacementNamed(context, '/OnboardFirst');
    // });

    context.read<SplashCubit>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFF7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //  crossAxisAlignment: CrossAxisAlignment.center ,
        children: [
          Center(
            child: Image.asset(
              'assets/images/splash2.gif',
              width: 130,
              height: 120,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Text(
              "Welcome To Artionet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'IM_Fell_DW_Pica_SC',
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
