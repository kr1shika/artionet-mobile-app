import 'package:flutter/material.dart';
import 'package:tryproject/view/artists_view/about_view.dart';
import 'package:tryproject/view/artists_view/artist_signup.dart';
import 'package:tryproject/view/customerProfileView.dart';
import 'package:tryproject/view/homeview.dart';
import 'package:tryproject/view/loginview.dart';
import 'package:tryproject/view/notification_view.dart';
import 'package:tryproject/view/onboard1.dart';
import 'package:tryproject/view/search_view.dart';
import 'package:tryproject/view/signupview.dart';
import 'package:tryproject/view/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/artistonboard': (context) => const OnboardingScreen_Artist(),
        '/artistSignupView': (context) => const ArtistSignupView(),
        '/OnboardFirst': (context) => const OnboardScreens(),
        '/login': (context) => const LoginView(),
        '/signup': (context) => const SignupView(),
        '/home': (context) => const HomeView(),
        '/search': (context) => const SearchView(),
        '/profile': (context) => const Customerprofileview(),
        '/notifications': (context) => const NotificationsView(),
      },
    );
  }
}
