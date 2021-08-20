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
  String email = '';
  String photoUrl = '';
  String role = '';
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
                email = userInfo['email'];
                name = userInfo['name'];
                photoUrl = userInfo['photoUrl'];
                role = userInfo['role'];
                print(name);
                return Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _createUser(userId, name, email, role),
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

  Widget _createUser(
    String userId,
    String name,
    String email,
    String role,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: CustomColors.foodBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onTap: () {},
        leading: Container(
          child: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(photoUrl),
          ),
        ),
        title: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: true,
        subtitle: Text(
          '$role\n$email',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.arrow_right,
              color: Colors.blue,
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
