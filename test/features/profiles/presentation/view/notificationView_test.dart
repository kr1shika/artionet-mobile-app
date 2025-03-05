import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:tryproject/core/app_theme/ThemeProvider.dart';
import 'package:tryproject/features/profiles/presentation/view/notificationView.dart';
import 'package:tryproject/features/profiles/presentation/view_model/profile_bloc.dart';
import 'package:tryproject/features/user-notification/domain/entity/notification_entity.dart';

class MockProfileBloc extends Mock implements ProfileBloc {}

void main() {
  late MockProfileBloc mockProfileBloc;

  setUp(() {
    mockProfileBloc = MockProfileBloc();
  });

  Widget loadNotificationsView() {
    return MultiProvider(
      providers: [
        Provider<ThemeProvider>(create: (_) => ThemeProvider()),
        BlocProvider<ProfileBloc>.value(value: mockProfileBloc),
      ],
      child: const MaterialApp(
        home: NotificationsView(userId: '1'),
      ),
    );
  }

  testWidgets('Check if "No notifications yet!" is displayed when there are no notifications', (tester) async {
  

    await tester.pumpWidget(loadNotificationsView());
    await tester.pumpAndSettle();

    expect(find.text("No notifications yet!"), findsOneWidget);
  });

  testWidgets('Check if a notification is displayed when available', (tester) async {
    final notification = NotificationEntity(
      notificationId: '1',
      userId: 'test_user',
      title: 'Test Notification',
      message: 'This is a test message.',
      createdAt: DateTime.now(),
      read: false,
      deleted: false,
    );


    await tester.pumpWidget(loadNotificationsView());
    await tester.pumpAndSettle();

    expect(find.text('Test Notification'), findsOneWidget);
    expect(find.text('This is a test message.'), findsOneWidget);
  });
}
