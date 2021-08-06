import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';

class MyContacts extends StatefulWidget {
  @override
  _MyContactsState createState() => _MyContactsState();
}

class _MyContactsState extends State<MyContacts> {
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: DatabaseUser.readMyContacts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('No se ha podido cargar los usuarios');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16.0),
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                print('total de usuarios: ${snapshot.data!.docs[index]}');
                var userInfo = snapshot.data!.docs[index];
                String userId = snapshot.data!.docs[index].id;
                String email = userInfo['email'];
                userInfo['name'] == null
                    ? name = 'Usuario'
                    : name = userInfo['name'];
                return Ink(
                  decoration: BoxDecoration(
                    color: CustomColors.firebaseGrey.withOpacity(1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _createUser(userId, email, name),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _createUser(String userId, String email, String name) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onTap: () {},
      leading: Icon(Icons.person),
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        email,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
