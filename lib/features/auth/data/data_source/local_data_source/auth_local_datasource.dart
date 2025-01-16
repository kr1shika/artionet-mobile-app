import 'dart:io';

import 'package:tryproject/core/network/hive_service.dart';
import 'package:tryproject/features/auth/data/data_source/auth_data_source.dart';
import 'package:tryproject/features/auth/data/model/auth_hive_model.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDatasource implements IAuthDataSource {
  final HiveService _hiveService;
  AuthLocalDatasource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    return Future.value(const AuthEntity(
      userId: "1",
      full_name: "",
      contact_no: '',
      role: '',
      password: '',
      email: '',
    ));
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      await _hiveService.login(email, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(user);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
