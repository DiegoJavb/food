import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/src/controllers/database_user_controller.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  String name = '';
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
                // String docId = snapshot.data!.docs[index].id;
                email = userInfo!['email'];
                userInfo['name'] == null
                    ? name = 'Usuario'
                    : name = userInfo['name'];
                if (userInfo['email'] == DatabaseUser.userUid) {
                  return SizedBox();
                } else {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(name),
                    subtitle: Text(email),
                    // trailing:
                    //     CheckContact(docId: docId, email: email, name: name),
                    // trailing: TextButton(
                    //   child: Text('Agregar'),
                    //   // child: CheckContact(
                    //   //   email: email,
                    //   // ),
                    //   onPressed: () {
                    //     DatabaseUser.addContact(
                    //       name: name,
                    //       email: email,
                    //       docId: docId,
                    //     );
                    //     Navigator.of(context).pop();
                    //   },
                    // ),
                  );
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
}

class CheckContact extends StatefulWidget {
  final String name;
  final String email;
  final String docId;
  const CheckContact({
    required this.email,
    required this.name,
    required this.docId,
    Key? key,
  }) : super(key: key);

  @override
  _CheckContactState createState() => _CheckContactState();
}

class _CheckContactState extends State<CheckContact> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: DatabaseUser.readMyContacts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('No se ha podido cargar los usuarios');
          } else if (snapshot.hasData || snapshot.data != null) {
            for (var contact in snapshot.data!.docs) {
              if (contact['email'] == widget.email) {
                return Icon(
                  Icons.check,
                  color: Colors.green,
                );
              }
              return IconButton(
                onPressed: () {
                  DatabaseUser.addContact(
                    name: widget.name,
                    email: widget.email,
                    docId: widget.docId,
                  );
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
