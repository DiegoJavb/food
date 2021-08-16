import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';

class RecomendationsPage extends StatefulWidget {
  @override
  _RecomendationsPageState createState() => _RecomendationsPageState();
}

class _RecomendationsPageState extends State<RecomendationsPage> {
  late String level;
  late String food;

  late TextEditingController _levelController = TextEditingController();
  late TextEditingController _foodController = TextEditingController();

  final _addFoodFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.foodNavy,
        title: Text('Recomendaciones'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: Column(
            children: [
              Header(
                height: 80.0,
              ),
              Body(
                height: 400.0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _llenarAlimento(context),
      ),
    );
  }

  void _llenarAlimento(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Form(
          key: _addFoodFormKey,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            title: Text('Alimento'),
            content: Container(
              child: ListView(
                children: <Widget>[_createFood(), Divider(), _createLevel()],
              ),
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
                onPressed: () async {
                  if (_addFoodFormKey.currentState!.validate()) {
                    await DatabaseUser.addRecomendation(
                      level: _levelController.text,
                      food: _foodController.text,
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  TextField _createFood() {
    return TextField(
      controller: _foodController,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Alimento',
        suffixIcon: Icon(Icons.food_bank_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        setState(() {
          food = valor;
        });
      },
    );
  }

  TextField _createLevel() {
    return TextField(
      controller: _levelController,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Unidades',
        suffixIcon: Icon(Icons.ac_unit_sharp),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        setState(() {
          level = valor;
        });
      },
    );
  }
}

class Header extends StatelessWidget {
  final double height;
  const Header({
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Nivel aceptado de consumo',
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: ListView(
        children: <Widget>[
          RecomemendationsList(),
        ],
      ),
    );
  }
}

class RecomemendationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseUser.readRecomendation(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return DataTable(
            columns: [
              DataColumn(label: Text('Alimento')),
              DataColumn(label: Text('Nivel aceptado')),
            ],
            rows: _createRows(snapshot.data!),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  List<DataRow> _createRows(QuerySnapshot snapshot) {
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return new DataRow(cells: [
        DataCell(Text(documentSnapshot['food'])),
        DataCell(Text(documentSnapshot['level'])),
      ]);
    }).toList();
    return newList;
  }
}
