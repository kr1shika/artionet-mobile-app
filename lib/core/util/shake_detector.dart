import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ShakeDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onShake;

  const ShakeDetector({super.key, required this.child, required this.onShake});

  @override
  _ShakeDetectorState createState() => _ShakeDetectorState();
}

class _ShakeDetectorState extends State<ShakeDetector> {
  static const double shakeThreshold = 15.0; // Adjust for sensitivity
  static const int debounceDuration = 1000; // 1 second debounce

  AccelerometerEvent? _previousEvent;
  DateTime? _lastShakeTime;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _listenToShake();
  }

  void _listenToShake() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      if (_previousEvent == null) {
        _previousEvent = event;
        return;
      }

      // Calculate acceleration difference
      double deltaX = (event.x - _previousEvent!.x).abs();
      double deltaY = (event.y - _previousEvent!.y).abs();
      double deltaZ = (event.z - _previousEvent!.z).abs();

      double acceleration = sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);

      if (acceleration > shakeThreshold) {
        DateTime now = DateTime.now();
        if (_lastShakeTime == null || now.difference(_lastShakeTime!) > const Duration(milliseconds: debounceDuration)) {
          _lastShakeTime = now;
          widget.onShake();
        }
      }

      _previousEvent = event;
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child; // Wraps the entire app
  }
}
