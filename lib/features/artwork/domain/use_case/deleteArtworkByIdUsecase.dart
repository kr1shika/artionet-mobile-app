import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

class DeleteArtworkByIdUseCase {
  final IArtworkRepository repository;

  DeleteArtworkByIdUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteArtworkbyId(id);
  }
}
