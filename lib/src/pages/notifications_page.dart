import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/widgets/notifications_list.dart';
import 'package:food/src/providers/currentUser.dart' as userName;

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('veamos si se setea de manera global: ${userName.nameUser}');
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Todas las notificaciones',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: NotificationsList(),
        ),
      ),
    );
  }
}
