import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';

class RecomendationsPage extends StatefulWidget {
  @override
  _RecomendationsPageState createState() => _RecomendationsPageState();
}

class _RecomendationsPageState extends State<RecomendationsPage> {
  late String _level = 'Permitido';
  late String _colorLevel = '#28A60F';
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
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  child: Column(
                    children: [
                      Text('Alimento'),
                      Form(
                        key: _addFoodFormKey,
                        child: Column(
                          children: <Widget>[
                            _createFood(),
                            Divider(),
                            // _createLevel(),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RadioListTile<int>(
                            title: Text(
                              'Permitido',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 0.1),
                            ),
                            value: 0,
                            groupValue: selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                selectedRadio = value!;
                                _level = 'Permitido';
                                _colorLevel = '#28A60F';
                              });
                            },
                          ),
                          RadioListTile<int>(
                            title: Text(
                              'Moderado',
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 0.1),
                            ),
                            value: 1,
                            groupValue: selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                selectedRadio = value!;
                                _level = 'Moderado';
                                _colorLevel = '#E6E61A';
                              });
                            },
                          ),
                          RadioListTile<int>(
                            title: Text(
                              'Evitar',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 0.1),
                            ),
                            value: 2,
                            groupValue: selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                selectedRadio = value!;
                                _level = 'Evitar';
                                _colorLevel = '#CD0722';
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
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
                    food: _foodController.text,
                    level: _level,
                    colorLevel: _colorLevel,
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
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
      String color = documentSnapshot['colorLevel'].replaceAll('#', '0xff');

      print('color que viene: $color');
      return new DataRow(cells: [
        DataCell(Text(documentSnapshot['food'])),
        DataCell(
          Text(
            documentSnapshot['level'],
            style: TextStyle(
              color: new Color(int.parse(color)),
            ),
          ),
        ),
      ]);
    }).toList();
    return newList;
  }
}
// COLORES HEXADECIMALES
// #CD0722 = red
// #28A60F = green
// #0000FF = blue
// #E6E61A = yellow
// #FF00FF = magenta
// #00FFFF = cyan
// #000000 = black
// #FFFFFF = white
// #FF9900 = orange
