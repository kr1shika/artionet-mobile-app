import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tryproject/app/constants/api_endpoints.dart';
import 'package:tryproject/features/auth/data/data_source/auth_data_source.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      // Make the API call to the login endpoint
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Extract the token from the response
        final token = response.data['token'];
        if (token != null) {
          return token; // Return the token
        } else {
          throw Exception("Token not found in the response");
        }
      } else {
        throw Exception("Failed to login: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors (e.g., network errors)
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      // Handle other errors
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
}
