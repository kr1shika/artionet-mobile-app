import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/presentation/view/search_view.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';

class MockArtworkBloc extends Mock implements ArtworkBloc {}

void main() {
  late MockArtworkBloc mockArtworkBloc;

  setUp(() {
    mockArtworkBloc = MockArtworkBloc();
  });

  Widget makeTestableWidget(Widget child) {
    return BlocProvider<ArtworkBloc>.value(
      value: mockArtworkBloc,
      child: MaterialApp(home: child),
    );
  }

  testWidgets('SearchView displays search results correctly', (tester) async {
    when(() => mockArtworkBloc.state).thenReturn(const ArtworkState(
      artworks: [
        ArtworkEntity(
          artworkId: '1',
          title: 'Sunset',
          dimensions: '20x30',
          price: '\$100',
          medium_used: 'Oil Paint',
          categories: 'Landscape',
        ),
      ],
      isLoading: false,
      likedStatuses: {},
    ));

    await tester.pumpWidget(makeTestableWidget(const SearchView()));

    await tester.enterText(find.byType(TextField), 'Sunset');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    expect(find.text('Sunset'), findsOneWidget);
  });

  // testWidgets('SearchView shows no results message when no artworks found',
  //     (tester) async {
  //   when(() => mockArtworkBloc.state).thenReturn(const ArtworkState(
  //     artworks: [],
  //     isLoading: false,
  //     likedStatuses: {},
  //   ));

  //   await tester.pumpWidget(makeTestableWidget(const SearchView()));
  //   await tester.enterText(find.byType(TextField), 'Unknown Artwork');
  //   await tester.testTextInput.receiveAction(TextInputAction.search);
  //   await tester.pump();

  //   expect(find.text('No matching artworks found.'), findsOneWidget);
  // });

  testWidgets('SearchView displays loading indicator during search',
      (tester) async {
    when(() => mockArtworkBloc.state).thenReturn(const ArtworkState(
      isLoading: true,
      artworks: [],
      likedStatuses: {},
    ));

    await tester.pumpWidget(makeTestableWidget(const SearchView()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('SearchView displays error message when search fails',
      (tester) async {
    when(() => mockArtworkBloc.state).thenReturn(const ArtworkState(
      errorMessage: 'Something went wrong',
      isLoading: false,
      artworks: [],
      likedStatuses: {},
    ));

    await tester.pumpWidget(makeTestableWidget(const SearchView()));
    await tester.pump();

    expect(find.text('Something went wrong'), findsOneWidget);
  });
}
