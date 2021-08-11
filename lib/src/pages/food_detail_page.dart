import 'package:flutter/material.dart';
import 'package:food/src/widgets/food_detail.dart';

class FoodDetailPage extends StatelessWidget {
  final String desayuno;
  final String almuerzo;
  final String cena;
  final String aperitivos;
  final String dias;
  final String enviado;
  final String notificationID;

  FoodDetailPage({
    required this.desayuno,
    required this.almuerzo,
    required this.cena,
    required this.aperitivos,
    required this.dias,
    required this.enviado,
    required this.notificationID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('detalle de comida'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: FoodDetail(
            desayuno: this.desayuno,
            almuerzo: this.almuerzo,
            cena: this.cena,
            aperitivos: this.aperitivos,
            dias: this.dias,
            enviado: this.enviado,
            notificacionID: this.notificationID,
          ),
        ),
      ),
    );
  }
}
