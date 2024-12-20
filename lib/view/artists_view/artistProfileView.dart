import 'package:flutter/material.dart';

class Artistprofileview extends StatelessWidget {
  const Artistprofileview({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Stack(
        children: [
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/krishika.jpg',
            height: 140,
            width: 412,
            fit: BoxFit.cover,
          ),
        ],
      ),
    ));
  }
}
