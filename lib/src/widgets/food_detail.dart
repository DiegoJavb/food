import 'package:flutter/material.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/utils/validator.dart';

import 'custom_form_field.dart';

class FoodDetail extends StatefulWidget {
  final String desayuno;
  final String almuerzo;
  final String cena;
  final String aperitivos;
  final String dias;
  final String enviado;
  final String notificacionID;
  //evaluacion alimenticia
  final FocusNode evaluationFocusNode;
  final String currentEvaluation;
  const FoodDetail({
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
                Text(
                  'Alimentacion',
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
                Text(
                  'Desayuno\n${widget.desayuno}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Almuerzo\n${widget.almuerzo}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Cena\n${widget.cena}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Aperitivos\n${widget.aperitivos}',
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
                CustomFormField(
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
                ),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.foodpink,
                    ),
                  ),
                )
              : Container(
                  child: FloatingActionButton.extended(
                    label: Text('Enviar'),
                    onPressed: () async {
                      if (_editItemFormKey.currentState!.validate()) {
                        setState(() => _isProcessing = true);
                        setState(() => _isProcessing = false);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
