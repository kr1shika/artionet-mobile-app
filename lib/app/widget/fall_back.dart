import 'package:flutter/material.dart';

class FallbackWidget extends StatelessWidget {
  const FallbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 36),
          Image.asset(
            'assets/images/server_down.png',
            height: 110,
            width: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          const Text(
            'No data found, go create art instead.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'IM_FELL_Great_Primer',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
