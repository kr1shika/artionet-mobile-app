import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tryproject/app/constants/hive_table_constant.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;

  @HiveField(1)
  final String full_name;

  @HiveField(2)
  final String contact_no;

  @HiveField(3)
  final String? password;

  @HiveField(4)
  final String? role;

  @HiveField(5)
  final String? profilepic;

  @HiveField(6)
  final String? artistname;

  @HiveField(7)
  final String? desc;

  @HiveField(8)
  final String email;

  AuthHiveModel(
      {String? userId,
      required this.full_name,
       this.role,
      required this.email,
      required this.contact_no,
       this.password,
      this.artistname,
      this.desc,
      this.profilepic})
      : userId = userId ?? const Uuid().v4();

  const AuthHiveModel.initial()
      : userId = "",
        full_name = "",
        role = "",
        email = "",
        contact_no = "",
        password = "",
        artistname = "",
        desc = "",
        profilepic = "";

  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
        userId: entity.userId,
        full_name: entity.full_name,
        role: entity.role,
        email: entity.email,
        contact_no: entity.contact_no,
        password: entity.password,
        profilepic: entity.profilepic,
        desc: entity.desc,
        artistname: entity.artistname);
  }

  AuthEntity toEntity() {
    return AuthEntity(
        full_name: full_name,
        contact_no: contact_no,
        password: password,
        role: role,
        email: email,
        profilepic: profilepic,
        desc: desc,
        artistname: artistname);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        userId,
        full_name,
        profilepic,
        email,
        contact_no,
        desc,
        artistname,
        role
      ];
}
