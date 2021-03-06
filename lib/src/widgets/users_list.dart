import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';
import 'package:food/src/providers/currentUser.dart' as userInformation;

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  String name = '';
  String email = '';
  String photoUrl = '';
  String role = '';
  String docId = '';
  var userInfo;
  var extradtedInfo;

  @override
  Widget build(BuildContext context) {
    print('Nobre del usuario actual: ${userInformation.nameUser}');
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
              separatorBuilder: (context, index) => SizedBox(height: 10.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                userInfo = snapshot.data!.docs[index];
                docId = snapshot.data!.docs[index].id;
                print('Id del usuario que quiero agregar: $docId');
                email = userInfo!['email'];
                name = userInfo['name'];
                photoUrl = userInfo['photo'];
                role = userInfo['role'];
                if (userInfo['email'] == DatabaseUser.userUid) {
                  return SizedBox();
                } else {
                  return Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _createContact(name, email, role, docId, photoUrl),
                  );
                }
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                CustomColors.foodProgress,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _createContact(
    String name,
    String email,
    String role,
    String docId,
    String photoUrl,
  ) {
    print('${userInformation.nameUser}');
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
        onTap: () {
          if (userInformation.nameUser == '' ||
              userInformation.nameUser == null) {
            Get.snackbar(
              'Actualice',
              'Su informacion personal para poder continuar',
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            DatabaseUser.addContact(
              name: name,
              email: email,
              photoUrl: photoUrl,
              role: role,
              docId: docId,
            );
            Get.snackbar(
              'Usuario a??adido a tus contactos',
              '',
            );
          }
        },
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
          '$role \n $email',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
