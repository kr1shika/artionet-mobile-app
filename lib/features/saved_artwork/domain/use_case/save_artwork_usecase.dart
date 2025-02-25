import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/saved_artwork/domain/entity/save_artwork_entity.dart';
import 'package:tryproject/features/saved_artwork/domain/repository/save_artwork_repository.dart';

class SaveArtworkParams extends Equatable {
  final String artId;
  final String buyerId;

  const SaveArtworkParams({
    required this.artId,
    required this.buyerId,
  });

  @override
  List<Object> get props => [artId, buyerId];
}

class SaveArtworkUsecase implements UsecaseWithParams<void, SaveArtworkParams> {
  final ISaveArtsRepository repository;

  SaveArtworkUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveArtworkParams params) async {
    final saveEntity = SaveArtworkEntity(
      art_id: params.artId,
      buyer_id: params.buyerId,
      status: "liked",
    );

    return await repository.save(saveEntity);
  }
}
