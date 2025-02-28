import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tryproject/app/di/di.dart';
import 'package:tryproject/core/app_theme/ThemeProvider.dart';
import 'package:tryproject/core/app_theme/app_theme.dart';
import 'package:tryproject/features/splash/presentation/view/splash_view.dart';
import 'package:tryproject/features/splash/presentation/view_model/splash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider.value(
          value: getIt<SplashCubit>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Artionet',
            theme: getApplicationTheme(isDarkMode: themeProvider.isDarkMode),
            home: const SplashView(),
          );
        },
      ),
    );
  }
}
