import 'package:flutter/material.dart';
import 'package:food/src/widgets/notifications_user_list.dart';

class NotificationDetailsPage extends StatelessWidget {
  final String userId;
  final String userName;
  NotificationDetailsPage({
    required this.userId,
    required this.userName,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: NotificationUserList(
            userId: this.userId,
          ),
        ),
      ),
    );
  }
}
