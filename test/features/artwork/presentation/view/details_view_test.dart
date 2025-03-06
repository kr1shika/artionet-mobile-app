import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/presentation/view/details_view.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';

class MockArtworkBloc extends Mock implements ArtworkBloc {
  @override
  Future<void> close() => Future.value(); 
}

void main() {
  late MockArtworkBloc mockArtworkBloc;

  setUp(() {
    mockArtworkBloc = MockArtworkBloc();

    registerFallbackValue(const FetchArtworkById('1'));
    registerFallbackValue(
        const CheckArtworkStatusEvent(artId: '1', buyerId: 'buyer123'));

    // Stub ArtworkBloc with initial state and stream
    when(() => mockArtworkBloc.state).thenReturn(ArtworkState.initial());
    when(() => mockArtworkBloc.stream)
        .thenAnswer((_) => Stream.value(ArtworkState.initial()));
    when(() => mockArtworkBloc.add(any()))
        .thenReturn(null); // Stub add to do nothing
  });

  // Helper method to build the testable widget
  Widget buildTestableWidget({bool showAppBar = false}) {
    return BlocProvider<ArtworkBloc>(
      create: (_) => mockArtworkBloc,
      child: MaterialApp(
        home: DetailView(
          artworkId: '1',
          buyerId: 'buyer123',
          isLiked: false,
          showAppBar: showAppBar,
        ),
      ),
    );
  }

  group('DetailView Simple Widget Tests', () {
    testWidgets('Shows loading indicator when state is loading',
        (WidgetTester tester) async {
      when(() => mockArtworkBloc.state).thenReturn(const ArtworkState(
        isLoading: true,
        artworks: [],
        likedStatuses: {},
      ));
      when(() => mockArtworkBloc.stream)
          .thenAnswer((_) => Stream.value(const ArtworkState(
                isLoading: true,
                artworks: [],
                likedStatuses: {},
              )));

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump(); 

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Shows artwork details when state has data',
        (WidgetTester tester) async {
      const artwork = ArtworkEntity(
        artworkId: '1',
        title: 'Test Artwork',
        dimensions: '10x10',
        price: '100',
        medium_used: 'Oil',
        artistId: 'artist1',
        categories: 'Abstract',
        creatorsNote: 'A beautiful piece',
        images: null, // Avoid network image loading
      );
      when(() => mockArtworkBloc.state).thenReturn(const ArtworkState(
        isLoading: false,
        artworks: [],
        likedStatuses: {},
        selectedArtwork: artwork,
      ));
      when(() => mockArtworkBloc.stream)
          .thenAnswer((_) => Stream.value(const ArtworkState(
                isLoading: false,
                artworks: [],
                likedStatuses: {},
                selectedArtwork: artwork,
              )));

      await tester.pumpWidget(buildTestableWidget(showAppBar: true));
      await tester.pump(); 
      await tester.pump(); 

      expect(find.text('Artwork Details'), findsOneWidget); 
      expect(find.text('Test Artwork'), findsOneWidget);
      expect(find.text('Medium: Oil'), findsOneWidget);
      expect(find.text('Price: 100'), findsOneWidget);
      expect(find.text('Purchase'), findsOneWidget);
    });

    testWidgets('Shows error message when state has error',
        (WidgetTester tester) async {
      when(() => mockArtworkBloc.state).thenReturn(const ArtworkState(
        isLoading: false,
        artworks: [],
        likedStatuses: {},
        errorMessage: 'Failed to load artwork',
      ));
      when(() => mockArtworkBloc.stream)
          .thenAnswer((_) => Stream.value(const ArtworkState(
                isLoading: false,
                artworks: [],
                likedStatuses: {},
                errorMessage: 'Failed to load artwork',
              )));

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump();

  
      expect(find.text('Failed to load artwork'), findsOneWidget);
    });
  });
}
