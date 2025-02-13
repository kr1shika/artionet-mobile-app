import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

class GetAllArtworkUsecase
    implements UsecaseWithoutParams<List<ArtworkEntity>> {
  final IArtworkRepository artworkRepository;

  GetAllArtworkUsecase({required this.artworkRepository});

  @override
  Future<Either<Failure, List<ArtworkEntity>>> call() {
    return artworkRepository.getArtworks();
  }
}
