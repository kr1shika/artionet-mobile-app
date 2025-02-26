import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tryproject/features/user-notification/domain/entity/notification_entity.dart';

part 'notification_api_model.g.dart';

@JsonSerializable()
class NotificationApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? notificationId;
  final String userId;
  final String title;
  final String message;
  final DateTime createdAt;
  final bool read;
  final bool deleted;

  const NotificationApiModel({
    this.notificationId,
    required this.userId,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.read,
    required this.deleted,
  });

  /// Convert JSON to `NotificationApiModel`
  factory NotificationApiModel.fromJson(Map<String, dynamic> json) {
    return NotificationApiModel(
      notificationId: json['_id'],
      userId: json['userId'],
      title: json['title'],
      message: json['message'],
      createdAt: json['createdAt'],
      read: json['read'],
      deleted: json['deleted'],
    );
  }

  /// Convert `NotificationApiModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'message': message,
      'createdAt': createdAt,
      'read': read,
      'deleted': deleted,
    };
  }

  /// Convert `NotificationEntity` to `NotificationApiModel`
  factory NotificationApiModel.fromEntity(NotificationEntity entity) =>
      NotificationApiModel(
        notificationId: entity.notificationId,
        userId: entity.userId,
        title: entity.title,
        message: entity.message,
        createdAt: entity.createdAt,
        read: entity.read,
        deleted: entity.deleted,
      );

  /// Convert `NotificationApiModel` to `NotificationEntity`
  NotificationEntity toEntity() => NotificationEntity(
        notificationId: notificationId,
        userId: userId,
        title: title,
        message: message,
        createdAt: createdAt,
        read: read,
        deleted: deleted,
      );

  /// Convert list of `NotificationApiModel` to list of `NotificationEntity`
  static List<NotificationEntity> toEntityList(
          List<NotificationApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        notificationId,
        userId,
        title,
        message,
        createdAt,
        read,
        deleted,
      ];
}
