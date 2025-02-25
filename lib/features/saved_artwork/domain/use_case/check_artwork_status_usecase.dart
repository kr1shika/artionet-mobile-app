import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/saved_artwork/domain/repository/save_artwork_repository.dart';

class CheckArtworkStatusParams extends Equatable {
  final String artId;
  final String buyerId;

  const CheckArtworkStatusParams({
    required this.artId,
    required this.buyerId,
  });

  @override
  List<Object> get props => [artId, buyerId];
}

class CheckArtworkStatusUsecase
    implements UsecaseWithParams<bool, CheckArtworkStatusParams> {
  final ISaveArtsRepository repository;

  CheckArtworkStatusUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(CheckArtworkStatusParams params) async {
    return await repository.checkStatus(params.artId, params.buyerId);
  }
}
