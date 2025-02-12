import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String full_name;
  final String contact_no;
  final String email;

  final String password;
  final String role;
  final String? desc;
  final String? profilepic;
  final String? artistname;

  const AuthEntity(
      {this.userId,
      required this.full_name,
      required this.contact_no,
      required this.password,
      required this.role,
      required this.email,
      this.desc,
      this.profilepic,
      this.artistname});

  const AuthEntity.empty()
      : userId = '_empty.userId',
        full_name = 'empty.full_name',
        contact_no = 'empty.contact_no',
        password = 'empty.password',
        email = 'empty.email',
        role = 'empty.role',
        desc = 'empty.desc',
        profilepic = 'empty.profilepic',
        artistname = 'empty.artistname';

  @override
  List<Object?> get props => [
        userId,
        full_name,
        contact_no,
        password,
        role,
        profilepic,
        artistname,
        desc,
        email
      ];
}
