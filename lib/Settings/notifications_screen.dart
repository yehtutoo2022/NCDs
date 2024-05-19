import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  // Dummy list of notifications
  final List<String> notifications = [
    "Notification 1: You have a new message.",
    "Notification 2: Today's weather is sunny.",
    "Notification 3: Event reminder - Meeting at 3:00 PM.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notifications),
            title: Text(notifications[index]),
            onTap: () {
              // Handle tapping on a notification (if needed)
            },
          );
        },
      ),
    );
  }
}
