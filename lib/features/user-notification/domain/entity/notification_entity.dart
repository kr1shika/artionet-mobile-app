import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String? notificationId;
  final String userId;
  final String title;
  final String message;
  final DateTime createdAt;
  final bool read;
  final bool deleted;

  const NotificationEntity(
      {this.notificationId,
      required this.createdAt,
      required this.read,
      required this.deleted,
      required this.message,
      required this.title,
      required this.userId});

  NotificationEntity.empty()
      : userId = '',
        createdAt = DateTime.now(),
        deleted = false,
        title = '',
        message = '',
        notificationId = '',
        read = false;

  @override
  // TODO: implement props
  List<Object?> get props =>
      [notificationId, createdAt, read, deleted, message, title, userId];
}
