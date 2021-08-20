import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/controllers/logout_controller.dart';
import 'package:food/src/pages/add_food_to_send_page.dart';
import 'package:food/src/pages/contactos_page.dart';
import 'package:food/src/pages/edit_user_page.dart';
import 'package:food/src/pages/my_contacts_page.dart';
import 'package:food/src/pages/notifications_page.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//Seteo de variables globales
import 'package:food/src/providers/currentUser.dart' as userInformation;

//llamada principal al la informacion del usuario
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class UserInfo extends StatefulWidget {
  late final String email;
  late final String role;
  UserInfo({
    required this.email,
    required this.role,
  });
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String docId = '';
  String photo = '';
  String name = '';
  String weight = '';
  String height = '';
  String age = '';

  @override
  void initState() {
    super.initState();
    DocumentReference userDocument = _mainCollection
        .doc(Database.userUid)
        .collection('information')
        .doc(Database.userUid);

    userDocument.get().then((snapshot) {
      setState(() {
        var userInfo = snapshot.data();
        print('toda la informacion: $userInfo');
        setState(() {
          docId = snapshot.id;
          photo = (userInfo as dynamic)['photo'];
          name = (userInfo as dynamic)['name'];
          weight = (userInfo as dynamic)['weight'];
          height = (userInfo as dynamic)['height'];
          age = (userInfo as dynamic)['age'];
          userInformation.nameUser = name;
          userInformation.photoUser = photo;
          userInformation.weightUser = weight;
          userInformation.heightUser = height;
          userInformation.ageUser = age;
          userInformation.emailUser = widget.email;
          userInformation.roleUser = widget.role;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('nombre del usuario actual: $name');
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.deepOrange, Colors.orangeAccent],
            ),
          ),
          child: Container(
            child: Column(
              children: <Widget>[
                photo == ''
                    ? CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.blueGrey[100],
                        child: Text(
                          widget.email[0].toUpperCase(),
                          style: TextStyle(fontSize: 40),
                        ),
                      )
                    : CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(photo),
                        backgroundColor: Colors.transparent,
                      ),
                SizedBox(height: 15.0),
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
            Get.to(
              () => EditUserPage(
                currentEmail: widget.email,
                currentRole: widget.role,
                currentage: this.age,
                currentheight: this.height,
                currentName: this.name,
                currentPhoto: this.photo,
                currentweight: this.weight,
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
          onTap: () => Get.to(() => NotificationsPage()),
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
}

class Logout extends StatelessWidget {
  final _controller = Get.put(LogoutController());
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetBuilder<LogoutController>(
      init: LogoutController(),
      builder: (_) {
        return FloatingActionButton.extended(
          key: _controller.logoutFormKey,
          heroTag: 'boton salir',
          label: const Text('Salir'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red[200],
          onPressed: () async {
            _.signOut();
          },
        );
      },
    ));
  }
}
