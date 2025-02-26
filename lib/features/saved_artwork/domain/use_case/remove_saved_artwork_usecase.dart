import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/saved_artwork/domain/repository/save_artwork_repository.dart';

class RemoveSavedArtworkParams extends Equatable {
  final String artId;
  final String buyerId;

  const RemoveSavedArtworkParams({
    required this.artId,
    required this.buyerId,
  });

  @override
  List<Object> get props => [artId, buyerId];
}

class RemoveSavedArtworkUsecase implements UsecaseWithParams<void, RemoveSavedArtworkParams> {
  final ISaveArtsRepository repository;

  RemoveSavedArtworkUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(RemoveSavedArtworkParams params) async {
    return await repository.removeFromCollection(params.artId, params.buyerId);
  }
}
