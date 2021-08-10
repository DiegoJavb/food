import 'package:flutter/material.dart';
// import 'package:food/src/widgets/search_users.dart';
import 'package:food/src/widgets/users_list.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // final _userController = TextEditingController();
  final ValueChanged<String> onChanged = (value) {};
  String name = '';
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UsersList(),
            ],
          ),
        ),
      ),
    );
  }
}
