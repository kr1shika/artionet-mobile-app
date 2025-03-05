import 'dart:io';

import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String email, String password);

  Future<void> registerUser(AuthEntity user);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);

  Future<AuthEntity> updateProfile(AuthEntity artist);

  Future<void> deleteUser(String userId);

  Future<List<AuthEntity>> getArtists();
}
