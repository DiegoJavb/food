import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/controllers/login_controller.dart';
import 'package:food/src/pages/contactos_page.dart';
import 'package:food/src/pages/edit_user_page.dart';
import 'package:food/src/pages/my_contacts_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late String docId;
  late String name;
  late String weight;
  late String height;
  late String age;
  late String email;
  late String role = '';
  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return ListView(
            key: _controller.formKey,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: DatabaseUser.readUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    var userInfo = snapshot.data!.docs[0].data();
                    print(
                      'informacion de usuario: $userInfo',
                    );
                    docId = snapshot.data!.docs[0].id;
                    name = (userInfo as dynamic)['name'];
                    weight = (userInfo as dynamic)['weight'];
                    height = (userInfo as dynamic)['height'];
                    age = (userInfo as dynamic)['age'];
                    email = (userInfo as dynamic)['email'];
                    role = (userInfo as dynamic)['role'];
                    print('id del documento $docId');
                    return UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: CustomColors.foodNavy),
                      accountEmail: Text(email),
                      accountName: Text(role),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.blueGrey[100],
                        child: Text(
                          email[0].toUpperCase(),
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        CustomColors.foodpink,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Actualizar información'),
                onTap: () {
                  Get.to(EditUserPage(
                    currentage: age,
                    currentheight: height,
                    currentweight: weight,
                    currentName: name,
                    currentEmail: email,
                    documentId: docId,
                  ));
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
                // title: role == 'nutritionist'
                //     ? Text('Pacientes')
                //     : Text('Nutricionistas'),
                onTap: () {
                  Get.to(() => MyContactsPage());
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.send),
                title: Text('Realizar consulta'),
                // onTap: () => Get.to(() => FoodRegisterPage()),
              ),
              Divider(),
              FloatingActionButton.extended(
                heroTag: 'boton salir',
                label: const Text('Salir'),
                foregroundColor: Colors.white,
                backgroundColor: Colors.red[200],
                onPressed: () async {
                  _.signOut();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
