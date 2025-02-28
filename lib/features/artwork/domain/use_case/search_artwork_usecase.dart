import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/data/repository/artwork_remote_repository.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

class SearchArtworksUsecase
    implements UsecaseWithParams<List<ArtworkEntity>, String> {
  final IArtworkRepository artworkRepository;

  SearchArtworksUsecase({required this.artworkRepository});

  @override
  Future<Either<Failure, List<ArtworkEntity>>> call(String query) {
    return artworkRepository.searchArtworks(query);
  }
}
