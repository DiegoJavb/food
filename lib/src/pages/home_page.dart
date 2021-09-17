import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/widgets/content_list.dart';
import 'package:food/src/widgets/user_info.dart' as user_info;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///Informacion basica del usuario
  String email = '';
  String role = '';

  ///Informacion completa del usuario
  String docId = '';
  String photo = '';
  String photoPath = '';
  String name = '';
  String weight = '';
  String height = '';
  String age = '';

  @override
  void initState() {
    super.initState();
    DocumentReference userDocument = _mainCollection.doc(Database.userUid);
    userDocument.get().then((snapshot) {
      setState(() {
        var userInfo = snapshot.data();
        print('toda la informacion: $userInfo');
        setState(() {
          email = (userInfo as dynamic)['email'];
          role = (userInfo as dynamic)['role'];
        });
      });
    });
    // DocumentReference userDocumentComplete = _mainCollection
    //     .doc(Database.userUid)
    //     .collection('information')
    //     .doc(Database.userUid);

    // userDocumentComplete.get().then((snapshot) {
    //   setState(() {
    //     var userInfo = snapshot.data();
    //     print('toda la informacion: $userInfo');
    //     setState(() {
    //       docId = snapshot.id;
    //       photo = (userInfo as dynamic)['photo'];
    //       photoPath = (userInfo as dynamic)['photoPath'];
    //       name = (userInfo as dynamic)['name'];
    //       weight = (userInfo as dynamic)['weight'];
    //       height = (userInfo as dynamic)['height'];
    //       age = (userInfo as dynamic)['age'];
    //       role = (userInfo as dynamic)['role'];
    //       userInformation.nameUser = name;
    //       userInformation.photoUser = photo;
    //       userInformation.weightUser = weight;
    //       userInformation.heightUser = height;
    //       userInformation.ageUser = age;
    //       userInformation.emailUser = email;
    //       userInformation.roleUser = role;
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    print(photo);
    return Scaffold(
        drawer: user_info.UserInfo(
          ///
          email: this.email,
          role: this.role,

          ///]
          // photo: this.photo,
          // photoPath: this.photoPath,
          // name: this.name,
          // weight: this.weight,
          // height: this.height,
          // age: this.age,
        ),
        appBar: CustomAppBar(title: 'Contenido'),
        body: Contentlist());
  }
}
