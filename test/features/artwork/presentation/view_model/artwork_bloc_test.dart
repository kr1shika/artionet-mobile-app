import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_all_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/search_artwork_usecase.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/purchases/presentation/view_model/purchase_bloc.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/check_artwork_status_usecase.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/remove_saved_artwork_usecase.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/save_artwork_usecase.dart';

class MockGetAllArtworkUsecase extends Mock implements GetAllArtworkUsecase {}

class MockGetArtworkByIdUsecase extends Mock implements GetArtworkByIdUsecase {}

class MockPurchaseBloc extends Mock implements PurchaseBloc {}

class MockSaveArtworkUsecase extends Mock implements SaveArtworkUsecase {}

class MockRemoveSavedArtworkUsecase extends Mock
    implements RemoveSavedArtworkUsecase {}

class MockCheckArtworkStatusUsecase extends Mock
    implements CheckArtworkStatusUsecase {}

class MockSearchArtworksUsecase extends Mock implements SearchArtworksUsecase {}

void main() {
  late GetAllArtworkUsecase getAllArtworkUsecase;
  late GetArtworkByIdUsecase getArtworkByIdUsecase;
  late PurchaseBloc purchaseBloc;
  late SaveArtworkUsecase saveArtworkUsecase;
  late RemoveSavedArtworkUsecase removeSavedArtworkUsecase;
  late CheckArtworkStatusUsecase checkArtworkStatusUsecase;
  late SearchArtworksUsecase searchArtworksUsecase;
  late ArtworkBloc artworkBloc;

  setUp(() {
    getAllArtworkUsecase = MockGetAllArtworkUsecase();
    getArtworkByIdUsecase = MockGetArtworkByIdUsecase();
    purchaseBloc = MockPurchaseBloc();
    saveArtworkUsecase = MockSaveArtworkUsecase();
    removeSavedArtworkUsecase = MockRemoveSavedArtworkUsecase();
    checkArtworkStatusUsecase = MockCheckArtworkStatusUsecase();
    searchArtworksUsecase = MockSearchArtworksUsecase();
    artworkBloc = ArtworkBloc(
        purchaseBloc: purchaseBloc,
        getAllArtworkUsecase: getAllArtworkUsecase,
        getArtworkByIdUsecase: getArtworkByIdUsecase,
        saveArtworkUsecase: saveArtworkUsecase,
        searchArtworksUsecase: searchArtworksUsecase,
        removeSavedArtworkUsecase: removeSavedArtworkUsecase,
        checkArtworkStatusUsecase: checkArtworkStatusUsecase);
  });

  const String testUserId = 'user123';
  final List<ArtworkEntity> testArtworks = [
    const ArtworkEntity(
      artworkId: 'art123',
      title: 'Abstract Painting',
      images: 'http://example.com/image.jpg',
      artistId: 'artist123',
      price: '200',
      creatorsNote: 'A beautiful abstract painting',
      isLiked: false,
      dimensions: 'ee',
      medium_used: 'we',
      categories: 'we',
    ),
  ];

  group('ArtworkBloc Tests', () {
    blocTest<ArtworkBloc, ArtworkState>(
      'SaveArtworkUsecase artworks',
      build: () {
        when(() => saveArtworkUsecase.call(testArtworks[0] as SaveArtworkParams))
            .thenAnswer((_) async => const Right(true));
        return artworkBloc;
      },

    );
  });
}
