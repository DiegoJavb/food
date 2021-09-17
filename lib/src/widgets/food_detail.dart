import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/utils/validator.dart';

import 'custom_form_field.dart';
import 'package:food/src/providers/currentUser.dart' as userInformation;

class FoodDetail extends StatefulWidget {
  ///
  final String peso;
  final String estatura;
  final String edad;

  ///
  final String desayuno;
  final String almuerzo;
  final String cena;
  final String aperitivos;
  final String dias;
  final String enviado;
  final String notificacionID;

  /// evaluacion alimenticia
  final FocusNode evaluationFocusNode;
  final String currentEvaluation;
  final String role;
  const FoodDetail({
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
    required this.notificacionID,
    //Evaluacion alimenticia
    required this.evaluationFocusNode,
    required this.currentEvaluation,
    required this.role,
    Key? key,
  }) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  final _editItemFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;
  late TextEditingController _evaluationController;
  @override
  void initState() {
    _evaluationController = new TextEditingController(
      text: widget.currentEvaluation,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editItemFormKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('${widget.edad} '),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('${widget.peso} Kg '),
                            SizedBox(height: 15.0),
                            Text('${widget.estatura} Cm '),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Alimentación',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Evaluación de: ${widget.dias} Días',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 15.0),
                Text('Desayuno',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text(
                  '${widget.desayuno}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 15.0),
                Text('Almuerzo',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text(
                  '${widget.almuerzo}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 15.0),
                Text('Cena',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text(
                  '${widget.cena}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 15.0),
                Text('Aperitivos',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text(
                  '${widget.aperitivos}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Evaluación',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                widget.role == 'Nutricionista'
                    ? CustomFormField(
                        maxLines: 5,
                        isLabelEnabled: false,
                        controller: _evaluationController,
                        focusNode: widget.evaluationFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        validator: (value) => Validator.validateField(
                          value: value,
                        ),
                        label: 'Evaluación',
                        hint: 'Ingrese la evaluación alimenticia',
                      )
                    : Text(
                        widget.currentEvaluation,
                        style: TextStyle(fontSize: 18.0),
                      ),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.foodBackground,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 200.0,
                      child: widget.role == 'Nutricionista'
                          ? Container(
                              width: 200.0,
                              child: FloatingActionButton.extended(
                                backgroundColor: Colors.white,
                                label: Text(
                                  'Enviar',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_editItemFormKey.currentState!
                                      .validate()) {
                                    setState(() => _isProcessing = true);
                                    DatabaseEvaluations.addFoodEvaluated(
                                      height: widget.estatura,
                                      weight: widget.peso,
                                      age: widget.edad,
                                      days: widget.dias,
                                      breakfast: widget.desayuno,
                                      lunch: widget.almuerzo,
                                      dinner: widget.cena,
                                      snack: widget.aperitivos,
                                      toUser: widget.enviado,
                                      carriedEvaluationId:
                                          widget.notificacionID,
                                      evaluation: _evaluationController.text,
                                    );
                                    DatabaseEvaluations.updateFoodEvaluated(
                                      days: widget.dias,
                                      breakfast: widget.desayuno,
                                      lunch: widget.almuerzo,
                                      dinner: widget.cena,
                                      snack: widget.aperitivos,
                                      toUser: widget.enviado,
                                      carriedEvaluationId:
                                          widget.notificacionID,
                                      evaluation: _evaluationController.text,
                                    );
                                    DatabaseEvaluations.addContact(
                                      fromUser: userInformation.nameUser!,
                                      emailFromUser: Database.userUid!,
                                      toUser: widget.enviado,
                                    );
                                    setState(() => _isProcessing = false);
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
