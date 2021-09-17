import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/widgets/notifications_list.dart';
import 'package:food/src/providers/currentUser.dart' as userName;

class NotificationsPage extends StatelessWidget {
  final String role;
  const NotificationsPage({
    required this.role,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('veamos si se setea de manera global: ${userName.nameUser}');
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notificaciones',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: NotificationsList(role: role),
        ),
      ),
    );
  }
}
