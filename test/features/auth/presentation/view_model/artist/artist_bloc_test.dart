import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artworks_by_userId.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/use_case/GetUserByIdUseCase.dart';
import 'package:tryproject/features/auth/domain/use_case/get_artists_usecase.dart';
import 'package:tryproject/features/auth/presentation/view_model/artist/artist_bloc.dart';

class MockGetartistsUsecase extends Mock implements GetartistsUsecase {}

class MockGetUserByIdUsecase extends Mock implements GetUserByIdUsecase {}

class MockGetArtworksByUseridUsecase extends Mock
    implements GetArtworksByUseridUsecase {}

void main() {
  // late GetartistsUsecase getartistsUsecase;
  late GetartistsUsecase getartistsUsecase;
  late GetUserByIdUsecase getUserByIdUsecase;
  late GetArtworksByUseridUsecase getArtworksByUseridUsecase;
  late ArtistBloc artistBloc;

  setUp(() {
    getartistsUsecase = MockGetartistsUsecase();
    getUserByIdUsecase = MockGetUserByIdUsecase();
    getArtworksByUseridUsecase = MockGetArtworksByUseridUsecase();

    artistBloc = ArtistBloc(
        // getartistsUsecase: getartistsUsecase,
        getUserByIdUsecase: getUserByIdUsecase,
        getArtworksByUseridUsecase: getArtworksByUseridUsecase,
        getartistsUsecase: getartistsUsecase);
  });

  group('ARtist_bloc testing', () {
    const artist = AuthEntity(
        userId: '1',
        full_name: 'Artist 1',
        contact_no: '1233',
        email: '@gmail.com');
    final List<AuthEntity> artistsList = [artist];
    const artwork = ArtworkEntity(
        artworkId: '1',
        title: 'Artwork 1',
        dimensions: '10x10',
        price: '100',
        images: 'http://example.com/image.jpg',
        artistId: '1',
        medium_used: 'mei',
        categories: 'i');
    final List<ArtworkEntity> artworksList = [artwork];

    const artists = AuthEntity(
        full_name: 'krishika', contact_no: '1233', email: '@gmail.com');
    const artists2 =
        AuthEntity(full_name: 'Sans', contact_no: '1233', email: '@.com');

    final results = [artists, artists2];

    blocTest<ArtistBloc, ArtistState>(
      'emits [loading, loaded artists] when FetchAllArtists is added',
      build: () {
        when(() => getartistsUsecase.call())
            .thenAnswer((_) async => Right(artistsList));
        return artistBloc;
      },
      act: (bloc) => bloc.add(FetchAllArtists()),
      expect: () => [
        ArtistState.initial().copyWith(isLoading: true),
        ArtistState.initial().copyWith(isLoading: false, artists: artistsList),
      ],
      verify: (_) {
        verify(() => getartistsUsecase.call()).called(1);
      },
    );

    blocTest<ArtistBloc, ArtistState>(
      'emits [loading, loaded user] when FetchUserById is added',
      build: () {
        when(() => getUserByIdUsecase.call('1'))
            .thenAnswer((_) async => const Right(artist));
        return artistBloc;
      },
      act: (bloc) => bloc.add(const FetchUserById('1')),
      expect: () => [
        ArtistState.initial().copyWith(isLoading: true),
        ArtistState.initial().copyWith(isLoading: false, selectedUser: artist),
      ],
      verify: (_) {
        verify(() => getUserByIdUsecase.call('1')).called(1);
      },
    );

    blocTest<ArtistBloc, ArtistState>(
      'emits [loading, loaded artworks] when FetchArtworksByUserId is added',
      build: () {
        when(() => getArtworksByUseridUsecase.call('1'))
            .thenAnswer((_) async => Right(artworksList));
        return artistBloc;
      },
      act: (bloc) => bloc.add(const FetchArtworksByUserId('1')),
      expect: () => [
        ArtistState.initial().copyWith(isLoading: true),
        ArtistState.initial()
            .copyWith(isLoading: false, artworks: artworksList),
      ],
      verify: (_) {
        verify(() => getArtworksByUseridUsecase.call('1')).called(1);
      },
    );
  });
}
