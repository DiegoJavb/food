import 'package:flutter/material.dart';
import 'package:food/src/controllers/logout_controller.dart';
import 'package:food/src/pages/add_food_to_send_page.dart';
import 'package:food/src/pages/contactos_page.dart';
import 'package:food/src/pages/edit_user_page.dart';
import 'package:food/src/pages/my_contacts_page.dart';
import 'package:food/src/pages/notifications_page.dart';
import 'package:get/get.dart';

class UserInfo extends StatefulWidget {
  ///Informacion basica del usuario
  late final String email;
  late final String role;

  ///informacion completa del usuario
  late final String photo;
  late final String name;
  late final String age;
  late final String height;
  late final String weight;
  UserInfo({
    required this.email,
    required this.role,
    required this.photo,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
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
    print('nombre del usuario actual: ${widget.name} o no');
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
                widget.photo == ''
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
                        backgroundImage: NetworkImage(widget.photo),
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
            Get.to(
              () => EditUserPage(
                currentEmail: widget.email,
                currentRole: widget.role,
                currentage: widget.age,
                currentheight: widget.height,
                currentName: widget.name,
                currentPhoto: widget.photo,
                currentweight: widget.weight,
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
                        () => AddFoodToSendPage(currentName: widget.name),
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
          },
        );
      },
    ));
  }
}
