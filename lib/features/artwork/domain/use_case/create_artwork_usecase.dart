import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

class CreateArtworkParams extends Equatable {
  final String title;
  final String dimensions;
  final String price;
  final String medium_used;
  final String? artistId;
  final String categories;
  final String? creatorsNote;
  final String? images;

  const CreateArtworkParams({
    required this.title,
    required this.dimensions,
    required this.price,
    required this.medium_used,
    this.artistId,
    required this.categories,
    this.creatorsNote,
    this.images,
  });

  @override
  List<Object?> get props =>
      [title, dimensions, price, medium_used, categories, creatorsNote, images];
}

class CreateArtworkUsecase
    implements UsecaseWithParams<ArtworkEntity, CreateArtworkParams> {
  final IArtworkRepository _repository;

  CreateArtworkUsecase(this._repository);

  @override
  Future<Either<Failure, ArtworkEntity>> call(CreateArtworkParams params) {
    final artworkEntity = ArtworkEntity(
        title: params.title,
        dimensions: params.dimensions,
        price: params.price,
        medium_used: params.medium_used,
        artistId: params.artistId,
        categories: params.categories,
        creatorsNote: params.creatorsNote,
        images: params.images);
    return _repository.createNewArtwork(artworkEntity);
  }
}
