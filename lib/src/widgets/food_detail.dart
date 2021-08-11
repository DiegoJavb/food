import 'package:flutter/material.dart';

class FoodDetail extends StatefulWidget {
  final String desayuno;
  final String almuerzo;
  final String cena;
  final String aperitivos;
  final String dias;
  final String enviado;
  final String notificacionID;
  const FoodDetail({
    required this.desayuno,
    required this.almuerzo,
    required this.cena,
    required this.aperitivos,
    required this.dias,
    required this.enviado,
    required this.notificacionID,
    Key? key,
  }) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
