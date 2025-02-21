import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

class GetArtworkByIdUsecase
    implements UsecaseWithParams<ArtworkEntity, String> {
  final IArtworkRepository artworkRepository;

  GetArtworkByIdUsecase({required this.artworkRepository});

  @override
  Future<Either<Failure, ArtworkEntity>> call(String id) {
    return artworkRepository.getArtworkById(id);
  }
}
