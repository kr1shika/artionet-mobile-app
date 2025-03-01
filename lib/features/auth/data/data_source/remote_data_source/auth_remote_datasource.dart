import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tryproject/app/constants/api_endpoints.dart';
import 'package:tryproject/app/shared_prefs/token_shared_prefs.dart';
import 'package:tryproject/features/auth/data/data_source/auth_data_source.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;

    final TokenSharedPrefs _tokenSharedPrefs; // ✅ Add TokenSharedPrefs

  AuthRemoteDatasource(this._dio, this._tokenSharedPrefs);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

Future<String> loginUser(String email, String password) async {
  try {
    Response response = await _dio.post(
      ApiEndpoints.login,
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final userId = data['id']; // ✅ Fetch userId from API response

      // ✅ Save only userId in SharedPreferences
      await _tokenSharedPrefs.saveLoginData(userId: userId);

      return userId; // ✅ Return only userId
    } else {
      throw Exception("Login Failed: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    throw Exception("Dio error: ${e.message}");
  } catch (e) {
    throw Exception("Unexpected error: $e");
  }
}


  // @override
  // Future<String> loginUser(String email, String password) async {
  //   try {
  //     // Make the API call to the login endpoint
  //     Response response = await _dio.post(
  //       ApiEndpoints.login,
  //       data: {
  //         "email": email,
  //         "password": password,
  //       },
  //     );

  //     // Check if the response is successful
  //     if (response.statusCode == 200) {
  //       // Extract the token from the response
  //       final token = response.data['token'];
  //       if (token != null) {
  //         return token; // Return the token
  //       } else {
  //         throw Exception("Token not found in the response");
  //       }
  //     } else {
  //       throw Exception("Failed to login: ${response.statusMessage}");
  //     }
  //   } on DioException catch (e) {
  //     // Handle Dio-specific errors (e.g., network errors)
  //     throw Exception("Dio error: ${e.message}");
  //   } catch (e) {
  //     // Handle other errors
  //     throw Exception("Unexpected error: $e");
  //   }
  // }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(ApiEndpoints.register, data: {
        "full_name": user.full_name,
        "contact_no": user.contact_no,
        "role": user.role,
        "password": user.password,
        "email": user.email,
        "profilepic": user.profilepic
      });
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'profilepic':
            await MultipartFile.fromFile(file.path, filename: fileName)
      });

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
