import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tryproject/features/auth/presentation/view/buyers/login_view.dart';
import 'package:tryproject/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends MockBLoc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() {
    loginBloc = MockLoginBloc();
  });

  Widget loadLoginView() {
    return BlocProvider<LoginBloc>(
      create: (create) => loginBloc,
      child: const MaterialApp(
        home: LoginView(),
      ),
    );
  }

  testWidgets('description', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();
    final result = find.widgetWithText(ElevatedButton, 'Login');
    expect(result, findsOneWidget);
  });

  testWidgets('check for email and password', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'krishika@hmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'krishi');

    await tester.tap(find.byType(ElevatedButton).first);

    await tester.pumpAndSettle();

    expect(find.text('krishika@hmail.com'), findsOneWidget);
    expect(find.text('krishi'), findsOneWidget);
  });

  testWidgets('check for  the validation error', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton).first);

    await tester.pumpAndSettle();

    expect(find.text('Please enter email'), findsOneWidget);
    expect(find.text('Please enter password'), findsOneWidget);
  });
}
