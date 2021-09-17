import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/controllers/logout_controller.dart';
import 'package:food/src/pages/add_food_to_send_page.dart';
import 'package:food/src/pages/contactos_page.dart';
import 'package:food/src/pages/edit_user_page.dart';
import 'package:food/src/pages/my_contacts_page.dart';
import 'package:food/src/pages/notifications_page.dart';
import 'package:get/get.dart';
import 'package:food/src/providers/currentUser.dart' as userInformation;

class UserInfo extends StatefulWidget {
  ///Informacion basica del usuario
  late final String email;
  late final String role;

  ///informacion completa del usuario
  // late final String photo;
  // late final String photoPath;
  // late final String name;
  // late final String age;
  // late final String height;
  // late final String weight;
  UserInfo({
    required this.email,
    required this.role,
    // required this.photo,
    // required this.photoPath,
    // required this.name,
    // required this.age,
    // required this.height,
    // required this.weight,
  });
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseUser.readUserInfo(widget.email),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('data');
          } else if (snapshot.hasData || snapshot.data != null) {
            var age = snapshot.data!['age'];
            var height = snapshot.data!['height'];
            var weight = snapshot.data!['weight'];
            var photo = snapshot.data!['photo'];
            var photoPath = snapshot.data!['photoPath'];
            var name = snapshot.data!['name'];
            var role = snapshot.data!['role'];
            print(role);
            return Drawer(
                child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.pink[300]!,
                        Colors.blue[300]!,
                      ],
                    ),
                  ),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        photo == ''
                            ? CircleAvatar(
                                radius: 40.0,
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.person,
                                ))
                            : CircleAvatar(
                                radius: 40.0,
                                backgroundImage: NetworkImage(photo),
                                backgroundColor: Colors.transparent,
                              ),
                        SizedBox(height: 10.0),
                        Text(
                          widget.email,
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          widget.role,
                          style: Theme.of(context).textTheme.subtitle2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Actualizar información'),
                  onTap: () {
                    setState(() {
                      userInformation.photoUser = photo;
                      userInformation.nameUser = name;
                      userInformation.ageUser = age;
                      userInformation.heightUser = height;
                      userInformation.weightUser = weight;
                      userInformation.roleUser = role;
                      userInformation.emailUser = widget.email;
                    });
                    Get.to(
                      () => EditUserPage(
                        currentEmail: widget.email,
                        currentRole: widget.role,
                        currentage: age,
                        currentheight: height,
                        currentName: name,
                        currentPhoto: photo,
                        currentPhotoPath: photoPath,
                        currentweight: weight,
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Lista de usuarios'),
                  onTap: () {
                    Get.to(() => ContactPage());
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text('Contactos'),
                  onTap: () {
                    Get.to(() => MyContactsPage());
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.library_add_check),
                  title: Text('Notificaciones'),
                  onTap: () =>
                      Get.to(() => NotificationsPage(role: widget.role)),
                ),
                Divider(),
                widget.role == 'Nutricionista'
                    ? SizedBox()
                    : Container(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.send),
                              title: Text('Realizar consulta'),
                              onTap: () => Get.to(
                                () => AddFoodToSendPage(currentName: name),
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      ),
                Container(
                  height: 16.0,
                ),
                Logout(),
              ],
            ));
          }
          return Text('data');
        });
  }
}

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  GlobalKey<FormState> logoutFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetBuilder<LogoutController>(
      init: LogoutController(),
      builder: (_) {
        return FloatingActionButton.extended(
          key: logoutFormKey,
          heroTag: 'boton salir',
          label: const Text('Salir'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red[200],
          onPressed: () async {
            _.signOut();
            setState(() {
              userInformation.ageUser = '';
              userInformation.emailUser = '';
              userInformation.heightUser = '';
              userInformation.nameUser = '';
              userInformation.photoUser = '';
              userInformation.roleUser = '';
              userInformation.weightUser = '';
            });
          },
        );
      },
    ));
  }
}
