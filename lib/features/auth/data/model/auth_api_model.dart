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
  final String? role;
  late String? profilepic;
  final String? artistname;
  final String? desc;
  final String email;
  final List<String>? followers;

  AuthApiModel(
      {this.id,
      required this.full_name,
      required this.contact_no,
      required this.password,
      required this.role,
      required this.profilepic,
      required this.artistname,
      required this.desc,
      required this.email,
      this.followers});

  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    String? profilePicUrl = json['profilepic'];
    if (profilePicUrl != null && !profilePicUrl.startsWith('http')) {
      profilePicUrl = 'http://192.168.1.71:5055/$profilePicUrl';
    }
    return _$AuthApiModelFromJson(json)..profilepic = profilePicUrl;
  }

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(
        profilepic: profilepic,
        userId: id,
        full_name: full_name,
        contact_no: contact_no,
        password: password ?? '',
        role: role,
        email: email,
        followers: followers ?? []);
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
        email: entity.email,
        followers: entity.followers);
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
        followers,
        profilepic,
      ];

  static Future<List<AuthEntity>> toEntityList(List<AuthApiModel> data) async {
    return data.map((model) => model.toEntity()).toList();
  }
}
