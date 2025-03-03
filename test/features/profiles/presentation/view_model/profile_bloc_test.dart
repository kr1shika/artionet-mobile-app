import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/deleteArtworkByIdUsecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artworks_by_userId.dart';
import 'package:tryproject/features/artwork/domain/use_case/update_artwork_usecase.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/auth/domain/use_case/GetCurrentUserUseCase.dart';
import 'package:tryproject/features/profiles/presentation/view_model/profile_bloc.dart';
import 'package:tryproject/features/profiles/presentation/view_model/upload_edit/crud_bloc.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/fetch_saved_artwork_by_userid.dart';
import 'package:tryproject/features/user-notification/domain/usecase/get_notification_usecase.dart';

class MockGetArtworksByUseridUsecase extends Mock
    implements GetArtworksByUseridUsecase {}

class MockGetArtworkByIdUsecase extends Mock implements GetArtworkByIdUsecase {}

class MockDeleteArtworkByIdUseCase extends Mock
    implements DeleteArtworkByIdUseCase {}

class MockGetSavedCollectionUsecase extends Mock
    implements GetSavedCollectionUsecase {}

class Mockartwork_bloc extends Mock implements ArtworkBloc {}

class MockartworkCrudBloc extends Mock implements ArtworkCrudBloc {}

class MockupdateArtworkUsecase extends Mock implements UpdateArtworkUsecase {}

class MockgetNotificationsByUserIdUsecase extends Mock
    implements GetNotificationsByUserIdUsecase {}

class MockgetUserByIdUsecase extends Mock implements GetUserByIdUsecase {}

void main() {
  late GetArtworkByIdUsecase getArtworkByIdUsecase;
  late GetArtworksByUseridUsecase getArtworksByUseridUsecase;
  late DeleteArtworkByIdUseCase deleteArtworkByIdUseCase;
  late GetSavedCollectionUsecase getSavedCollectionUsecase;
  late ArtworkBloc artworkBloc;
  late ArtworkCrudBloc artworkCrudBloc;
  late UpdateArtworkUsecase updateArtworkUsecase;
  late GetNotificationsByUserIdUsecase getNotificationsByUserIdUsecase;
  late GetUserByIdUsecase getUserByIdUsecase;
  late ProfileBloc profileBloc;

  setUp(() {
    getArtworkByIdUsecase = MockGetArtworkByIdUsecase();
    getArtworksByUseridUsecase = MockGetArtworksByUseridUsecase();
    deleteArtworkByIdUseCase = MockDeleteArtworkByIdUseCase();
    getSavedCollectionUsecase = MockGetSavedCollectionUsecase();

    artworkBloc = artworkBloc;
    artworkCrudBloc = artworkCrudBloc;
    updateArtworkUsecase = MockupdateArtworkUsecase();
    getUserByIdUsecase = MockgetUserByIdUsecase();
    getNotificationsByUserIdUsecase = MockgetNotificationsByUserIdUsecase();

    profileBloc = ProfileBloc(
        artwork_bloc: artworkBloc,
        getArtworksByUseridUsecase: getArtworksByUseridUsecase,
        artworkCrudBloc: artworkCrudBloc,
        getArtworkByIdUsecase: getArtworkByIdUsecase,
        deleteArtworkByIdUseCase: deleteArtworkByIdUseCase,
        getSavedCollectionUsecase: getSavedCollectionUsecase,
        updateArtworkUsecase: updateArtworkUsecase,
        getNotificationsByUserIdUsecase: getNotificationsByUserIdUsecase,
        getUserByIdUsecase: getUserByIdUsecase);
  });

  final List<ArtworkEntity> testArtworks = [
    const ArtworkEntity(
        title: 'love',
        dimensions: '2',
        price: '73264',
        medium_used: 'meow',
        categories: 'hey',
        artistId: 'user123',
        images: 'http://example.com'),
    const ArtworkEntity(
        title: 'art101',
        dimensions: '2',
        price: '73264',
        medium_used: 'meow',
        categories: 'hey',
        artistId: '101',
        images: 'http://example.com'),
  ];

  group('tests for methods in profile bloc', () {
    blocTest('emit users artwork when getArtworksByUseridUsecase', build: () {
      when(() => getArtworksByUseridUsecase.call('user123'))
          .thenAnswer((_) async => Right(testArtworks));
      return profileBloc;
    }, act: (bloc) {
      bloc.add(const FetchArtworkByUserID(userId: 'user123'));
    }, expect: () {
      return [
        ProfileState.initial().copyWith(isLoading: true),
        ProfileState.initial().copyWith(
            artworks: testArtworks, isLoading: false, errorMessage: null)
      ];
    }, verify: (_) {
      verify(() => getArtworksByUseridUsecase.call('user123')).called(1);
    });
  });
}
