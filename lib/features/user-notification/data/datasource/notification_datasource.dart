import 'package:tryproject/features/user-notification/domain/entity/notification_entity.dart';

abstract interface class INotificationDataSource {
  Future<List<NotificationEntity>> getArtistsNotification(String userId);
}
