import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/widgets/content_list.dart';
import 'package:food/src/widgets/user_info.dart' as user_info;
import 'package:food/src/providers/currentUser.dart' as userInformation;

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
    DocumentReference userDocumentComplete = _mainCollection
        .doc(Database.userUid)
        .collection('information')
        .doc(Database.userUid);

    userDocumentComplete.get().then((snapshot) {
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
          userInformation.emailUser = email;
          userInformation.roleUser = role;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: user_info.UserInfo(
          ///
          email: this.email,
          role: this.role,

          ///]
          photo: this.photo,
          name: this.name,
          weight: this.weight,
          height: this.height,
          age: this.age,
        ),
        appBar: CustomAppBar(title: 'Contenido'),
        body: Contentlist()

        // child: CustomScrollView(
        //   slivers: <Widget>[
        //     SliverAppBar(
        //       automaticallyImplyLeading: true,
        //       iconTheme: IconThemeData(
        //         color: Colors.white,
        //       ),
        //       floating: true,
        //       pinned: true,
        //       centerTitle: true,
        //       title: Text(
        //         'Contenido',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 30.0,
        //           fontWeight: FontWeight.bold,
        //           letterSpacing: 1.0,
        //         ),
        //       ),
        //       expandedHeight: 100.0,
        //       flexibleSpace: Stack(
        //         children: [
        //           Positioned.fill(
        //             child: Image.network(
        //               "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Contentlist()
        //   ],
        // ),

        );
  }
}
