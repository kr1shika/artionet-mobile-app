import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:tryproject/features/profiles/presentation/view_model/profile_bloc.dart';
import 'package:tryproject/features/user-notification/domain/entity/notification_entity.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class NotificationsView extends StatefulWidget {
  final String userId;

  const NotificationsView({super.key, required this.userId});

  @override
  NotificationsViewState createState() => NotificationsViewState();
}

class NotificationsViewState extends State<NotificationsView> {
  static const double forwardTiltThreshold = 3.0; // Adjust as needed

  @override
  void initState() {
    super.initState();
    _listenToGyroscope();
    context
        .read<ProfileBloc>()
        .add(FetchNotificationsByUserId(userId: widget.userId));
  }

  void _listenToGyroscope() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (event.y > forwardTiltThreshold) {
        final themeProvider =
            Provider.of<ThemeProvider>(context, listen: false);
        themeProvider.toggleTheme();
      }
    });
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
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage.isNotEmpty) {
              return Center(
                  child: Text(
                state.errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ));
            } else if (state.notifications.isEmpty) {
              return const Center(
                child: Text(
                  "No notifications yet!",
                  style: TextStyle(
                    fontFamily: 'IM_FELL_Great_Primer',
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              );
            } else {
              // Categorize notifications
              final categorizedNotifications =
                  _categorizeNotifications(state.notifications);

              return Column(
                children: [
                  // Fixed "Notifications" title
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 16),
                  //   child:
                  // ),
                  // // List of notifications
                  const Text(
                    "Tilt forward to change theme",
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        // Recent Notifications Section
                        if (categorizedNotifications['Recent']!.isNotEmpty)
                          _buildNotificationSection(context, 'Recent',
                              categorizedNotifications['Recent']!),
                        // Last 20 Days Section
                        if (categorizedNotifications['Last 20 Days']!
                            .isNotEmpty)
                          _buildNotificationSection(context, 'Last 20 Days',
                              categorizedNotifications['Last 20 Days']!),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // Helper method to build a notification section
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

  // Helper method to format DateTime
  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }
}
