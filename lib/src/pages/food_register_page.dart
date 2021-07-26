import 'package:flutter/material.dart';
import 'package:food/src/pages/edit_user_page.dart';

class FoodRegisterPage extends StatefulWidget {
  @override
  _FoodRegisterPageState createState() => _FoodRegisterPageState();
}

class _FoodRegisterPageState extends State<FoodRegisterPage> {
  final _addFoodFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Register'),
      ),
      body: ListView(
        children: [
          Form(
            key: _addFoodFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Header(
                  height: 170.0,
                  userImage: 'images/userPhoto.jpg',
                ),
                Body(height: 250.0),
                Footer(
                  height: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final double height;
  final String userImage;
  const Header({
    required this.height,
    required this.userImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UserPhoto(
            size: 90.0, userName: '',
            // userImage: this.userImage,
          ),
        ],
      ),
    );
  }
}

class Body extends StatefulWidget {
  final double height;
  const Body({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // final _addFoodFormKey = GlobalKey<FormState>();
  late int units;
  late String food;
  late double quantity;

  late TextEditingController _unitsController = TextEditingController();
  late TextEditingController _foodController = TextEditingController();
  late TextEditingController _quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView(
        children: <Widget>[
          DataTable(
            columnSpacing: 5.0,
            columns: [
              DataColumn(
                label: Text('U'),
              ),
              DataColumn(
                label: Text('Alimento'),
              ),
              DataColumn(
                label: Text('Cantidad "(Kg)"'),
              ),
            ],
            rows: [],
          ),
          TextButton(
            onPressed: () => _llenarAlimento(context),
            child: Text('Agregar alimento'),
          ),
        ],
      ),
    );
  }

  void _llenarAlimento(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          title: Text('Alimento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createUnits(),
              _createFood(),
              _createQuantity(),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Agregar'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  TextField _createUnits() {
    return TextField(
      controller: _unitsController,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre',
        icon: Icon(Icons.account_circle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        units = valor as int;
      },
    );
  }

  TextField _createFood() {
    return TextField(
      controller: _foodController,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre',
        icon: Icon(Icons.account_circle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        food = valor;
      },
    );
  }

  TextField _createQuantity() {
    return TextField(
      controller: _quantityController,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre',
        icon: Icon(Icons.account_circle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        quantity = valor as double;
      },
    );
  }
}

class Footer extends StatelessWidget {
  final double height;
  const Footer({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: Text('Enviar'),
          )
        ],
      ),
    );
  }
}
