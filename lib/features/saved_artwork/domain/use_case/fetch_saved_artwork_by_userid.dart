import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/saved_artwork/domain/entity/save_artwork_entity.dart';
import 'package:tryproject/features/saved_artwork/domain/repository/save_artwork_repository.dart';

class GetSavedCollectionUsecase
    implements UsecaseWithParams<List<SaveArtworkEntity>, String> {
  final ISaveArtsRepository repository;

  GetSavedCollectionUsecase(this.repository);

  @override
  Future<Either<Failure, List<SaveArtworkEntity>>> call(String buyerId) async {
    return await repository.getCollection(buyerId);
  }
}
