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

// import 'package:dartz/dartz.dart';
// import 'package:tryproject/app/usecase/usecase.dart';
// import 'package:tryproject/core/common/internet_checker/internet_checker.dart';
// import 'package:tryproject/core/error/failure.dart';
// import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
// import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

// class GetAllArtworkUsecase
//     implements UsecaseWithoutParams<List<ArtworkEntity>> {
//   final IArtworkRepository remoteArtworkRepository;
//   final IArtworkRepository localArtworkRepository;
//   final NetworkInfo networkInfo;

//   GetAllArtworkUsecase({
//     required this.remoteArtworkRepository,
//     required this.localArtworkRepository,
//     required this.networkInfo,
//   });

//   @override
//   Future<Either<Failure, List<ArtworkEntity>>> call() async {
//     // Check network connectivity
//     if (await networkInfo.isConnected) {
//       print("Network connected: ${await networkInfo.isConnected}");

//       // If internet is available, fetch from the server and save to the local DB
//       final result = await remoteArtworkRepository.getArtworks();
//       return result.fold(
//         (failure) => Left(failure), // Return failure if there's an error
//         (artworks) async {
//           // Save fetched artworks to local database
//           await localArtworkRepository.saveAllArtworks(artworks);
//           return Right(artworks); // Return fetched artworks
//         },
//       );
//     } else {
//       // If no internet, fetch from the local database
//       return localArtworkRepository.getArtworks();
//     }
//   }
// }
