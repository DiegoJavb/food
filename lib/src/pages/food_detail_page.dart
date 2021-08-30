import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/widgets/food_detail.dart';

class FoodDetailPage extends StatelessWidget {
  // datos del usuario
  final String peso;
  final String estatura;
  final String edad;
  //datos de la alimentacion
  final String desayuno;
  final String almuerzo;
  final String cena;
  final String aperitivos;
  final String dias;
  final String enviado;
  final String notificationID;
  final String currentEvaluation;

  FoodDetailPage({
    ///
    required this.peso,
    required this.estatura,
    required this.edad,

    ///
    required this.desayuno,
    required this.almuerzo,
    required this.cena,
    required this.aperitivos,
    required this.dias,
    required this.enviado,
    required this.notificationID,

    ///currentEvaluation
    required this.currentEvaluation,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode _evaluationFocusNode = FocusNode();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detalle de comida',
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: FoodDetail(
            ///
            peso: this.peso,
            estatura: this.estatura,
            edad: this.edad,

            ///
            desayuno: this.desayuno,
            almuerzo: this.almuerzo,
            cena: this.cena,
            aperitivos: this.aperitivos,
            dias: this.dias,
            enviado: this.enviado,
            notificacionID: this.notificationID,

            ///evaluacion
            currentEvaluation: this.currentEvaluation,
            evaluationFocusNode: _evaluationFocusNode,
          ),
        ),
      ),
    );
  }
}
