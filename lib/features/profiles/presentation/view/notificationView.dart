import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:tryproject/core/app_theme/ThemeProvider.dart';
import 'package:tryproject/features/profiles/presentation/view_model/profile_bloc.dart';
import 'package:tryproject/features/user-notification/domain/entity/notification_entity.dart';

// Fallback Widget
class FallbackWidget extends StatelessWidget {
  const FallbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/server_down.png',
            height: 110,
            width: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          const Text(
            'Go create art instead.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'IM_FELL_Great_Primer',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Loading Widget
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class NotificationsView extends StatefulWidget {
  final String userId;

  const NotificationsView({super.key, required this.userId});

  @override
  NotificationsViewState createState() => NotificationsViewState();
}

class NotificationsViewState extends State<NotificationsView> {
  static const double forwardTiltThreshold = 3.0;
  static const Duration cooldownDuration = Duration(seconds: 10);
  StreamSubscription? _gyroscopeSubscription;
  DateTime? _lastToggleTime;

  @override
  void initState() {
    super.initState();
    _startListening();
    context
        .read<ProfileBloc>()
        .add(FetchNotificationsByUserId(userId: widget.userId));
  }

  void _startListening() {
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      if (!mounted) return;
      final now = DateTime.now();

      if (_lastToggleTime == null ||
          now.difference(_lastToggleTime!) > cooldownDuration) {
        if (event.y > forwardTiltThreshold) {
          final themeProvider =
              Provider.of<ThemeProvider>(context, listen: false);
          themeProvider.toggleTheme();
          _lastToggleTime = now;
        }
      }
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  Map<String, List<NotificationEntity>> _categorizeNotifications(
      List<NotificationEntity> notifications) {
    final now = DateTime.now();
    final recentNotifications = notifications
        .where((notification) =>
            now.difference(notification.createdAt).inDays <= 7)
        .toList();
    final last20DaysNotifications = notifications
        .where((notification) =>
            now.difference(notification.createdAt).inDays > 7 &&
            now.difference(notification.createdAt).inDays <= 20)
        .toList();
    return {
      'Recent': recentNotifications,
      'Last 20 Days': last20DaysNotifications,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Image.asset(
              'assets/images/logo.png',
              height: 42,
              fit: BoxFit.contain,
            ),
          ),
          body: SafeArea(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                // Show loading widget when data is being fetched
                if (state.isLoading) {
                  return const LoadingWidget();
                }
                // Handle "no notifications" case as empty data rather than error
                else if (state.errorMessage
                        .contains("No notifications found") ||
                    state.notifications.isEmpty) {
                  return const FallbackWidget();
                }
                // Show actual errors that aren't "no notifications"
                else if (state.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  );
                }
                // Show notifications list when data is available
                else {
                  final categorizedNotifications =
                      _categorizeNotifications(state.notifications);
                  final hasNotifications =
                      categorizedNotifications['Recent']!.isNotEmpty ||
                          categorizedNotifications['Last 20 Days']!.isNotEmpty;

                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Tilt forward to change theme",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: hasNotifications
                            ? ListView(
                                children: [
                                  if (categorizedNotifications['Recent']!
                                      .isNotEmpty)
                                    _buildNotificationSection(context, 'Recent',
                                        categorizedNotifications['Recent']!),
                                  if (categorizedNotifications['Last 20 Days']!
                                      .isNotEmpty)
                                    _buildNotificationSection(
                                        context,
                                        'Last 20 Days',
                                        categorizedNotifications[
                                            'Last 20 Days']!),
                                ],
                              )
                            : const FallbackWidget(),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationSection(BuildContext context, String sectionTitle,
      List<NotificationEntity> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDateTime(notification.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }
}
