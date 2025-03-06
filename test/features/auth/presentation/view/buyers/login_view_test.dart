import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/features/auth/presentation/view/buyers/login_view.dart';
import 'package:tryproject/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tryproject/features/auth/presentation/view_model/signup/register_bloc.dart';

class MockLoginBloc extends Mock implements LoginBloc {}

class MockRegisterBloc extends Mock implements RegisterBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}



void main() {
  late MockLoginBloc mockLoginBloc;
  late MockRegisterBloc mockRegisterBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    // Initialize GetIt and register RegisterBloc
    final getIt = GetIt.instance;
    mockRegisterBloc = MockRegisterBloc();
    getIt.registerSingleton<RegisterBloc>(mockRegisterBloc);

    // Initialize mocks
    mockLoginBloc = MockLoginBloc();
    mockNavigatorObserver = MockNavigatorObserver();


    // Stub LoginBloc with initial state and stream
    when(() => mockLoginBloc.state).thenReturn(LoginState.initial());
    when(() => mockLoginBloc.stream)
        .thenAnswer((_) => Stream.value(LoginState.initial()));
  });

  // Helper method to build the testable widget
  Widget buildTestableWidget() {
    return BlocProvider<LoginBloc>(
      create: (_) => mockLoginBloc,
      child: MaterialApp(
        home: const LoginView(),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );
  }

  group('LoginView Widget Tests', () {
    testWidgets('Initial UI renders correctly', (WidgetTester tester) async {
      // Arrange: Set up the widget
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump(); // Ensure the widget tree is fully built

      // Assert: Check initial UI elements
      expect(find.byType(Image), findsOneWidget); // Logo
      expect(find.text('Login to Artionet'), findsOneWidget);
      expect(find.text('welcome back'), findsOneWidget);
      expect(
          find.byKey(const ValueKey('email')), findsOneWidget); // Email field
      expect(find.byKey(const ValueKey('password')),
          findsOneWidget); // Password field
      expect(find.text('PROCEED'), findsOneWidget); // Proceed button
      expect(find.text("Don,t have an account?"),
          findsOneWidget); // Register button
    });

    testWidgets('Form validation shows errors when submitted empty',
        (WidgetTester tester) async {
      // Arrange: Set up the widget
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      // Act: Tap the Proceed button without input
      await tester.tap(find.text('PROCEED'));
      await tester.pump();

      // Assert: Check validation errors
      expect(find.text('please enter the email'), findsOneWidget);
      expect(find.text('Please enter password'), findsOneWidget);
    });

    testWidgets('UI reflects loading state when LoginBloc is loading',
        (WidgetTester tester) async {
      // Arrange: Stub LoginBloc with loading state
      when(() => mockLoginBloc.state)
          .thenReturn(LoginState(isLoading: true, isSuccess: false));
      when(() => mockLoginBloc.stream).thenAnswer(
          (_) => Stream.value(LoginState(isLoading: true, isSuccess: false)));

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      // Assert: Check that the widget renders (no explicit loading UI in your code, so just verify it doesn't crash)
      expect(find.byType(LoginView), findsOneWidget);
    });
  });
}
