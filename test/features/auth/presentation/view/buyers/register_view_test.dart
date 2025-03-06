import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/features/auth/presentation/view/buyers/register_view.dart';
import 'package:tryproject/features/auth/presentation/view_model/signup/register_bloc.dart';

// Mock class
class MockRegisterBloc extends Mock implements RegisterBloc {}

void main() {
  late MockRegisterBloc mockRegisterBloc;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    when(() => mockRegisterBloc.state).thenReturn(RegisterState.initial());
    when(() => mockRegisterBloc.stream)
        .thenAnswer((_) => Stream.value(RegisterState.initial()));
  });

  // Helper method to build the testable widget
  Widget buildTestableWidget() {
    return BlocProvider<RegisterBloc>(
      create: (_) => mockRegisterBloc,
      child: const MaterialApp(home: RegisterView()),
    );
  }

  group('RegisterView Simple Widget Tests', () {
    testWidgets('Initial UI renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      // Assert: Check basic UI elements
      expect(find.byType(Image), findsOneWidget); // Logo
      expect(find.text('Sign up to artionet'), findsOneWidget);
      expect(find.byType(CircleAvatar),
          findsOneWidget); // Profile picture placeholder
      expect(find.byType(TextFormField),
          findsNWidgets(4)); // Full name, contact, email, password fields
      expect(find.text('SIGN UP'), findsOneWidget);
      expect(find.text('Already have an account?'), findsOneWidget);
    });

    testWidgets('Form validation shows errors when submitted empty',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(800, 1200);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      final signUpButton = find.text('SIGN UP');
      await tester.ensureVisible(signUpButton);
      await tester.pumpAndSettle();
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter Full name.'), findsOneWidget);
      expect(find.text('Please enter Contact Number'), findsOneWidget);
      expect(find.text('Please enter Email.'), findsOneWidget);
      expect(find.text('Please create a password.'), findsOneWidget);

      addTearDown(() => tester.binding.window.clearPhysicalSizeTestValue());
    });

    testWidgets('Tapping profile picture opens image selection bottom sheet',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue =
          const Size(800, 1200); 
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      await tester.tap(find.byType(CircleAvatar));
      await tester.pumpAndSettle(); 

      expect(find.text('Camera'), findsOneWidget);
      expect(find.text('Gallery'), findsOneWidget);

      addTearDown(() => tester.binding.window.clearPhysicalSizeTestValue());
    });
  });
}
