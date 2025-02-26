import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

class UpdateArtworkParams extends Equatable {
  final String artworkId;
  final String title;
  final String dimensions;
  final String price;
  final String mediumUsed;
  final String categories;
  final String? creatorsNote;
  final String? images;

  const UpdateArtworkParams({
    required this.artworkId,
    required this.title,
    required this.dimensions,
    required this.price,
    required this.mediumUsed,
    required this.categories,
    this.creatorsNote,
    this.images,
  });

  @override
  List<Object?> get props => [
        artworkId,
        title,
        dimensions,
        price,
        mediumUsed,
        categories,
        creatorsNote,
        images,
      ];
}

class UpdateArtworkUsecase
    implements UsecaseWithParams<ArtworkEntity, UpdateArtworkParams> {
  final IArtworkRepository _repository;

  UpdateArtworkUsecase(this._repository);

  @override
  Future<Either<Failure, ArtworkEntity>> call(UpdateArtworkParams params) {
    final artworkEntity = ArtworkEntity(
      artworkId: params.artworkId,
      title: params.title,
      dimensions: params.dimensions,
      price: params.price,
      medium_used: params.mediumUsed,
      categories: params.categories,
      creatorsNote: params.creatorsNote,
      images: params.images,
    );
    return _repository.updateArtwork(artworkEntity);
  }
}
