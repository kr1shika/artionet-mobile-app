import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tryproject/app/constants/api_endpoints.dart';
import 'package:tryproject/app/shared_prefs/token_shared_prefs.dart';
import 'package:tryproject/features/auth/data/data_source/auth_data_source.dart';
import 'package:tryproject/features/auth/data/dto/getArtists_dto.dart';
import 'package:tryproject/features/auth/data/model/auth_api_model.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;

  final TokenSharedPrefs _tokenSharedPrefs; // ✅ Add TokenSharedPrefs

  AuthRemoteDatasource(this._dio, this._tokenSharedPrefs);

  @override
  Future<AuthEntity> getCurrentUser() async {
    try {
      var userId = _tokenSharedPrefs.getUserId();
      var response = await _dio.get('${ApiEndpoints.getUserById}/$userId');

      // var response = await _dio
      //     .get('${ApiEndpoints.getUserById}/\${_tokenSharedPrefs.getUserId()}');
      if (response.statusCode == 200) {
        return AuthApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception("Failed to fetch user data");
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
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

  @override
  Future<AuthEntity> updateProfile(AuthEntity artist) async {
    try {
      String? userId = _tokenSharedPrefs.getUserId();
      print("🔍 [DEBUG] User ID from SharedPreferences: $userId");

      // Check if the profile picture is a URL (i.e., user did not update it)
      String profilePic = artist.profilepic ?? "";
      if (profilePic.startsWith("http://") ||
          profilePic.startsWith("https://")) {
        // Extract only the filename from the URL
        Uri uri = Uri.parse(profilePic);
        profilePic = uri.pathSegments.last; // Extracts "IMG-1738322199503.jpg"
      }

      final data = {
        "full_name": artist.full_name,
        "contact_no": artist.contact_no,
        "email": artist.email,
        "profilepic": profilePic, // Now sending only the filename
      };

      print(
          "📤 [DEBUG] Sending request to: ${ApiEndpoints.updateProfile}/$userId");
      print("📝 [DEBUG] Request Body: $data");

      Response response = await _dio.put(
        '${ApiEndpoints.updateProfile}/$userId',
        data: data,
        options: Options(headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );

      print("✅ [DEBUG] Response Status: ${response.statusCode}");
      print("📥 [DEBUG] Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return AuthApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(
            "❌ Failed to update profile: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error: ${e.message}");
      print("📥 [DEBUG] Dio Response: ${e.response?.data}");
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      print("⚠️ [DEBUG] Unexpected Error: $e");
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      Response response = await _dio.delete(
        '${ApiEndpoints.deleteUser}/$userId',
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception("Failed to delete user: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<List<AuthEntity>> getArtists() async {
    try {
      var response = await _dio.get(ApiEndpoints.getArtists);
      if (response.statusCode == 200) {
        GetAllArtistsDTO artistsDTO = GetAllArtistsDTO.fromJson(response.data);
        return AuthApiModel.toEntityList(artistsDTO.data);
      } else {
        throw Exception("Failed to fetch artists: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
