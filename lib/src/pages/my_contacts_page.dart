import 'package:flutter/material.dart';
import 'package:food/src/widgets/my_contacts.dart';

class MyContactsPage extends StatefulWidget {
  @override
  _MyContactsPageState createState() => _MyContactsPageState();
}

class _MyContactsPageState extends State<MyContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 20.0,
        ),
        child: Column(
          children: <Widget>[
            MyContacts(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Get.toNamed('addAppointment');
        },
      ),
    );
  }
}
