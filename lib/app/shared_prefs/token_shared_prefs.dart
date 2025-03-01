import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryproject/core/error/failure.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  /// Save user login data
  Future<Either<Failure, void>> saveLoginData({
    required String userId,
  }) async {
    try {
      await _sharedPreferences.setString('userId', userId);

      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  String? getUserId() {
    return _sharedPreferences.getString('userId');
  }
}
