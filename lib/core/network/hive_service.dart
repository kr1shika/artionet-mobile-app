import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tryproject/app/constants/hive_table_constant.dart';
import 'package:tryproject/features/artwork/data/model/artwork_hive_model.dart';
import 'package:tryproject/features/auth/data/model/auth_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}softwarica_student_management.db';

    Hive.init(path);

    // Register Adapters

    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(ArtworkHiveModelAdapter());
  }

  // Save artworks to Hive
  Future<void> saveAllArtworks(List<ArtworkHiveModel> artworks) async {
    var box =
        await Hive.openBox<ArtworkHiveModel>(HiveTableConstant.artworkBox);
    await box.addAll(artworks); // Save list of artworks to the box
  }

  // Get all artworks from Hive
  Future<List<ArtworkHiveModel>> getAllArts() async {
    var box =
        await Hive.openBox<ArtworkHiveModel>(HiveTableConstant.artworkBox);
    return box.values.toList(); // Return all artwork models from the box
  }

  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  Future<AuthHiveModel> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    try {
      return box.values.firstWhere(
        (element) => element.email == email && element.password == password,
      );
    } catch (e) {
      throw Exception(
          "Invalid email or password."); // Explicitly throw an exception.
    }
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
