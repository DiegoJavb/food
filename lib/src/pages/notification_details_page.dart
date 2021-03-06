import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/widgets/notifications_user_list.dart';

class NotificationDetailsPage extends StatelessWidget {
  final String userId;
  final String userName;
  final String role;
  NotificationDetailsPage({
    required this.userId,
    required this.userName,
    required this.role,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: userName,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: NotificationUserList(
            userId: this.userId,
            role: this.role,
          ),
        ),
      ),
    );
  }
}
