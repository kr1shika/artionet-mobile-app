import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

class GetArtworksByUseridUsecase
    implements UsecaseWithParams<List<ArtworkEntity>, String> {
  final IArtworkRepository artworkRepository;

  GetArtworksByUseridUsecase({required this.artworkRepository});

  @override
  Future<Either<Failure, List<ArtworkEntity>>> call(String id) {
    return artworkRepository.getArtworksbyUserId(id);
  }
}
