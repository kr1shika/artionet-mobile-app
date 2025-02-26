import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/user-notification/data/datasource/notification_remote_datasource.dart';
import 'package:tryproject/features/user-notification/domain/entity/notification_entity.dart';
import 'package:tryproject/features/user-notification/domain/repository/notification_repository.dart';

class NotificationRemoteRepository implements INotificationRepository {
  final NotificationRemoteDatasource remoteDatasource;

  NotificationRemoteRepository({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getArtistsNotification(
      String userId) async {
    try {
      final notifications =
          await remoteDatasource.getArtistsNotification(userId);
      return Right(notifications);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
