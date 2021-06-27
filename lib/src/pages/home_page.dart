import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
                  _cardTipo1(),
                  _cardTipo1(),
                  _cardTipo1(),
                  _cardTipo1(),
                  _cardTipo1(),
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
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.photo,
              color: Colors.blue,
            ),
            title: Text('Este es el título de la tarjeta'),
            subtitle: Text(
                'este sool es el  subtitulño que quiero que sea un tanto largo para poder apreciasr mejor la tarjeta'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text('Ver'),
                onPressed: () {},
              )
            ],
          )
        ],
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
