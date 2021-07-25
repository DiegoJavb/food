import 'package:flutter/material.dart';
import 'package:food/src/widgets/my_contacts.dart';
import 'package:food/src/widgets/search_users.dart';
import 'package:food/src/widgets/users_list.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _userController = TextEditingController();
  final ValueChanged<String> onChanged = (value) {};
  String name = '';
  String query = '';
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _isSearching
                ? Container(
                    child: MyContacts(),
                  )
                : Container(
                    child: UsersList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildSearch() {
    return SearchUser(
      name: 'name',
      onChanged: (value) {},
    );
  }
}
