// import 'package:flutter/material.dart';
// import 'package:tryproject/app/app.dart';
// import 'package:tryproject/app/di/di.dart';
// import 'package:tryproject/core/network/hive_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await HiveService.init();

//   // await HiveService().clearStudentBox();

//   await initDependencies();

//   runApp(
//     const App(),
//   );
// }

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tryproject/app/app.dart';
import 'package:tryproject/app/di/di.dart';
import 'package:tryproject/core/network/hive_service.dart';
import 'package:tryproject/features/artwork/data/model/artwork_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  var box = await Hive.openBox<ArtworkHiveModel>('artworkBox');
  var allArtworks = box.values.toList();
  print("Total artworks in Hive: ${allArtworks.length}");

  await initDependencies();

  runApp(
    const RestartWidget(child: App()), // Wrap the app with RestartWidget
  );
}

class RestartWidget extends StatefulWidget {
  final Widget child;
  const RestartWidget({super.key, required this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey(); // Generates a new key, forcing app rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
