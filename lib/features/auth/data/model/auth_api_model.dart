import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String full_name;
  final String contact_no;
  final String? password;
  final String role;
  final String? profilepic;
  final String? artistname;
  final String? desc;
  final String email;

  const AuthApiModel(
      {this.id,
      required this.full_name,
      required this.contact_no,
      required this.password,
      required this.role,
      required this.profilepic,
      required this.artistname,
      required this.desc,
      required this.email});

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(
        userId: id,
        full_name: full_name,
        contact_no: contact_no,
        password: password ?? '',
        role: role,
        email: email);
  }

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
        full_name: entity.full_name,
        contact_no: entity.contact_no,
        password: entity.password,
        role: entity.role,
        profilepic: entity.profilepic,
        artistname: entity.artistname,
        desc: entity.desc,
        email: entity.email);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        full_name,
        contact_no,
        email,
        password,
        role,
      ];
}
