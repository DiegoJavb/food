import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/src/controllers/database_user_controller.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  String name = '';
  String docId = '';
  String email = '';
  var userInfo;
  var extradtedInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: DatabaseUser.readUsersOfListUsers(),
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
                userInfo = snapshot.data!.docs[index];
                docId = snapshot.data!.docs[index].id;
                print('Id del usuario que quiero agregar: $docId');
                email = userInfo!['email'];
                name = userInfo['name'] == '' ? 'Usuario' : userInfo['name'];
                if (userInfo['email'] == DatabaseUser.userUid) {
                  return SizedBox();
                } else {
                  return Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _createContact(name, email, docId),
                  );
                  // return ListTile(
                  //   leading: Icon(Icons.person),
                  //   title: Text(name),
                  //   subtitle: Text(email),
                  //   trailing: IconButton(
                  //     onPressed: () {
                  //       DatabaseUser.addContact(
                  //         name: name,
                  //         email: email,
                  //         docId: docId,
                  //       );
                  //       setState(() {});
                  //       Navigator.of(context).pop();
                  //     },
                  //     icon: Icon(
                  //       Icons.add,
                  //       color: Colors.blue,
                  //     ),
                  //   ),
                  // );
                }
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

  Widget _createContact(String name, String email, String docId) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onTap: () {
        DatabaseUser.addContact(
          name: name,
          email: email,
          docId: docId,
        );
        Navigator.of(context).pop();
      },
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
      trailing: Icon(
        Icons.add,
        color: Colors.blue,
        size: 30.0,
      ),
    );
  }
}
