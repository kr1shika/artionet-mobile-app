import 'package:dio/dio.dart';
import 'package:tryproject/app/constants/api_endpoints.dart';
import 'package:tryproject/features/user-notification/data/datasource/notification_datasource.dart';
import 'package:tryproject/features/user-notification/data/model/notification_api_model.dart';
import 'package:tryproject/features/user-notification/domain/entity/notification_entity.dart';

class NotificationRemoteDatasource implements INotificationDataSource {
  final Dio _dio;

  NotificationRemoteDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<List<NotificationEntity>> getArtistsNotification(String userId) async {
    try {
      var response =
          await _dio.get("${ApiEndpoints.getUserNotification}/$userId");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data
            .map((item) => NotificationApiModel.fromJson(item).toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
