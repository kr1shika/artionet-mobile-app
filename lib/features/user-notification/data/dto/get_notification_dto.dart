import 'package:json_annotation/json_annotation.dart';
import 'package:tryproject/features/user-notification/data/model/notification_api_model.dart';

part 'get_notification_dto.g.dart';

@JsonSerializable()
class GetNotificationDto {
  final bool success;
  final int count;
  final List<NotificationApiModel> data;

  GetNotificationDto({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetNotificationDtoToJson(this);

  factory GetNotificationDto.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationDtoFromJson(json);
}
