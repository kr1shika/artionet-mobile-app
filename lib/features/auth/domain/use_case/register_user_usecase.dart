import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String full_name;
  final String contact_no;
  final String email;
  final String role;
  final String password;
  final String? artistname;
  final String? profilepic;

  const RegisterUserParams(
      {required this.full_name,
      required this.email,
      required this.contact_no,
      required this.role,
      required this.password,
      this.artistname,
      this.profilepic});

  //intial constructor
  const RegisterUserParams.initial(
    this.profilepic, {
    required this.full_name,
    required this.email,
    required this.contact_no,
    required this.role,
    required this.password,
    this.artistname,
  });

  @override
  List<Object?> get props =>
      [full_name, email, contact_no, role, password, artistname];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
        full_name: params.full_name,
        email: params.email,
        contact_no: params.contact_no,
        role: params.role,
        password: params.password,
        artistname: params.artistname,
        profilepic: params.profilepic);
    return repository.registerUser(authEntity);
  }
}
