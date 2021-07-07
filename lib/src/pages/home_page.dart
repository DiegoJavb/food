import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/login_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.put(LoginController());
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      body: Material(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: true,
              floating: true,
              pinned: true,
              title: Text('Usuario'),
              expandedHeight: 150.0,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 20.0,
                  ),
                  _cardTipo1(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardTipo1() {
    final card = Container(
      width: 250.0,
      child: Row(
        children: [
          FadeInImage(
            image: NetworkImage(
                'https://s1.1zoom.me/big3/471/Painting_Art_Back_view_Photographer_575380_3840x2400.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 125.0,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {
                Get.toNamed('record');
              },
              child: Text(
                'Historial',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 8.0))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return ListView(
            key: _controller.formKey,
            children: [
              ListTile(
                title: Text('Usuario: '),
              ),
              ListTile(
                title: Text('Usuario: '),
              ),
              FloatingActionButton.extended(
                heroTag: 'boton salir',
                label: const Text('Salir'),
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                onPressed: () async {
                  _.signOut();
                  // Get.toNamed('/');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
