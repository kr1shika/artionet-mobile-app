import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/user-notification/domain/entity/notification_entity.dart';
import 'package:tryproject/features/user-notification/domain/repository/notification_repository.dart';

class GetNotificationsByUserIdUsecase
    implements UsecaseWithParams<List<NotificationEntity>, String> {
  final INotificationRepository notificationRepository;

  GetNotificationsByUserIdUsecase({required this.notificationRepository});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(String userId) {
    return notificationRepository.getArtistsNotification(userId);
  }
}
