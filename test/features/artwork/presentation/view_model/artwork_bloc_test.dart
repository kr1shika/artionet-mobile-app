import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/create_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/deleteArtworkByIdUsecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_all_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artworks_by_userId.dart';
import 'package:tryproject/features/artwork/domain/use_case/search_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/update_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/upload_artwork_image_usecase.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/use_case/GetUserByIdUseCase.dart';
import 'package:tryproject/features/auth/presentation/view_model/artist/artist_bloc.dart';
import 'package:tryproject/features/purchases/presentation/view_model/purchase_bloc.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/check_artwork_status_usecase.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/remove_saved_artwork_usecase.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/save_artwork_usecase.dart';

// Mock classes using mocktail
class MockGetAllArtworkUsecase extends Mock implements GetAllArtworkUsecase {}

class MockGetArtworkByIdUsecase extends Mock implements GetArtworkByIdUsecase {}

class MockGetArtworksByUserIdUsecase extends Mock
    implements GetArtworksByUseridUsecase {}

class MockCreateArtworkUsecase extends Mock implements CreateArtworkUsecase {}

class MockUpdateArtworkUsecase extends Mock implements UpdateArtworkUsecase {}

class MockUploadArtworkUsecase extends Mock implements UploadArtworkUsecase {}

class MockDeleteArtworkByIdUsecase extends Mock
    implements DeleteArtworkByIdUseCase {}

class MockSaveArtworkUsecase extends Mock implements SaveArtworkUsecase {}

class MockRemoveSavedArtworkUsecase extends Mock
    implements RemoveSavedArtworkUsecase {}

class MockCheckArtworkStatusUsecase extends Mock
    implements CheckArtworkStatusUsecase {}

class MockSearchArtworksUsecase extends Mock implements SearchArtworksUsecase {}

class MockGetUserByIdUsecase extends Mock implements GetUserByIdUsecase {}

class MockPurchaseBloc extends Mock implements PurchaseBloc {}

class MockArtistBloc extends Mock implements ArtistBloc {}

void main() {
  late GetAllArtworkUsecase getAllArtworkUsecase;
  late GetArtworkByIdUsecase getArtworkByIdUsecase;

  late SaveArtworkUsecase saveArtworkUsecase;
  late RemoveSavedArtworkUsecase removeSavedArtworkUsecase;
  late CheckArtworkStatusUsecase checkArtworkStatusUsecase;
  late SearchArtworksUsecase searchArtworksUsecase;
  late GetUserByIdUsecase getUserByIdUsecase;
  late PurchaseBloc purchaseBloc;
  late ArtistBloc artistBloc;
  late ArtworkBloc artworkBloc;

  setUp(() {
    getAllArtworkUsecase = MockGetAllArtworkUsecase();
    getArtworkByIdUsecase = MockGetArtworkByIdUsecase();

    saveArtworkUsecase = MockSaveArtworkUsecase();
    removeSavedArtworkUsecase = MockRemoveSavedArtworkUsecase();
    checkArtworkStatusUsecase = MockCheckArtworkStatusUsecase();
    searchArtworksUsecase = MockSearchArtworksUsecase();
    getUserByIdUsecase = MockGetUserByIdUsecase();
    purchaseBloc = MockPurchaseBloc();
    artistBloc = MockArtistBloc();
    when(() => getAllArtworkUsecase.call())
        .thenAnswer((_) async => const Right([]));

    artworkBloc = ArtworkBloc(
      purchaseBloc: purchaseBloc,
      getAllArtworkUsecase: getAllArtworkUsecase,
      getArtworkByIdUsecase: getArtworkByIdUsecase,
      saveArtworkUsecase: saveArtworkUsecase,
      searchArtworksUsecase: searchArtworksUsecase,
      removeSavedArtworkUsecase: removeSavedArtworkUsecase,
      checkArtworkStatusUsecase: checkArtworkStatusUsecase,
      artistBloc: artistBloc,
      getUserByIdUsecase: getUserByIdUsecase,
    );
  });

  const String testArtworkId = 'art1';
  const String testUserId = 'user1';
  const String testQuery = 'painting';
  final List<ArtworkEntity> testArtworks = [
    const ArtworkEntity(
      artworkId: 'art1',
      title: 'Artwork 1',
      dimensions: '10x10',
      price: '100',
      medium_used: 'Oil',
      images: 'http://example.com/image1.jpg',
      archive: null,
      artistId: 'artist1',
      categories: 'Painting',
      creatorsNote: 'A beautiful painting',
      isLiked: false,
    ),
    const ArtworkEntity(
      artworkId: 'art2',
      title: 'Artwork 2',
      dimensions: '20x20',
      price: '200',
      medium_used: 'Acrylic',
      images: 'http://example.com/image2.jpg',
      archive: null,
      artistId: 'artist1',
      categories: 'Sculpture',
      creatorsNote: 'An amazing sculpture',
      isLiked: false,
    ),
  ];

  const authEntity = AuthEntity(
      userId: 'user1',
      full_name: 'User 1',
      email: 'user1@example.com',
      contact_no: 'meo'
      // Add other required fields as per your AuthEntity
      );

  group('ArtworkBloc Tests', () {
    // 1. Emits [ArtworkState] with searched artworks when SearchArtworksEvent is successful
    blocTest<ArtworkBloc, ArtworkState>(
      'emits [ArtworkState] with searched artworks when SearchArtworksEvent is successful',
      build: () {
        when(() => searchArtworksUsecase.call(testQuery))
            .thenAnswer((_) async => Right(testArtworks));
        return artworkBloc;
      },
      act: (bloc) => bloc.add(const SearchArtworksEvent(testQuery)),
      expect: () => [
        ArtworkState.initial().copyWith(isLoading: true, errorMessage: null),
        ArtworkState.initial().copyWith(
          isLoading: false,
          artworks: testArtworks,
        ),
      ],
      verify: (_) {
        verify(() => searchArtworksUsecase.call(testQuery)).called(1);
      },
    );

// 2. Emits [ArtworkState] with error when SearchArtworksEvent fails with a non-404 error
    blocTest<ArtworkBloc, ArtworkState>(
      'emits [ArtworkState] with error when SearchArtworksEvent fails with a non-404 error',
      build: () {
        when(() => searchArtworksUsecase.call(testQuery)).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Server Error')));
        return artworkBloc;
      },
      act: (bloc) => bloc.add(const SearchArtworksEvent(testQuery)),
      expect: () => [
        ArtworkState.initial().copyWith(isLoading: true, errorMessage: null),
        ArtworkState.initial().copyWith(
          isLoading: false,
          errorMessage: 'Server Error',
        ),
      ],
      verify: (_) {
        verify(() => searchArtworksUsecase.call(testQuery)).called(1);
      },
    );

// 3. Emits [ArtworkState] with empty artworks when SearchArtworksEvent returns 404
    blocTest<ArtworkBloc, ArtworkState>(
      'emits [ArtworkState] with empty artworks when SearchArtworksEvent returns 404',
      build: () {
        when(() => searchArtworksUsecase.call(testQuery)).thenAnswer(
            (_) async =>
                const Left(ApiFailure(message: 'No matching artworks found.')));
        return artworkBloc;
      },
      act: (bloc) => bloc.add(const SearchArtworksEvent(testQuery)),
      expect: () => [
        ArtworkState.initial().copyWith(isLoading: true, errorMessage: null),
        ArtworkState.initial().copyWith(
          isLoading: false,
          artworks: [],
        ),
      ],
      verify: (_) {
        verify(() => searchArtworksUsecase.call(testQuery)).called(1);
      },
    );
  });
}
