import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/purchases/domain/repository/purchase_repository.dart';

class GetArtistSalesUsecase
    implements UsecaseWithParams<List<PurchaseEntity>, String> {
  final IPurchaseRepository purchaseRepository;

  GetArtistSalesUsecase({required this.purchaseRepository});

  @override
  Future<Either<Failure, List<PurchaseEntity>>> call(String artistId) {
    return purchaseRepository.getArtistSales(artistId);
  }
}
