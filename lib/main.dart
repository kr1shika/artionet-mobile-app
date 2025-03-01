import 'package:flutter/material.dart';
import 'package:tryproject/app/app.dart';
import 'package:tryproject/app/di/di.dart';
import 'package:tryproject/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // await HiveService().clearStudentBox();

  await initDependencies();

  runApp(
    const App(),
  );
}
