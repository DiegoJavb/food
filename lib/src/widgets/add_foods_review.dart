import 'package:flutter/material.dart';
import 'package:food/src/pages/select_contact_to_sen_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/utils/validator.dart';
import 'package:get/get.dart';
import 'custom_form_field.dart';

class AddFoodsReview extends StatefulWidget {
  final FocusNode breakfastFocusNode;
  final FocusNode lunchFocusNode;
  final FocusNode dinnerFocusNode;
  final FocusNode snackFocusNode;
  final String currentName;

  const AddFoodsReview({
    required this.breakfastFocusNode,
    required this.lunchFocusNode,
    required this.dinnerFocusNode,
    required this.snackFocusNode,
    required this.currentName,
  });

  @override
  _AddFoodsReviewState createState() => _AddFoodsReviewState();
}

class _AddFoodsReviewState extends State<AddFoodsReview> {
  final _addFoodReviewFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;
  String dropdownValue = 'Un';
  final TextEditingController _breakfastController = TextEditingController();
  final TextEditingController _lunchController = TextEditingController();
  final TextEditingController _dinnerController = TextEditingController();
  final TextEditingController _snackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addFoodReviewFormKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _createForm(),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(
                    backgroundColor: CustomColors.foodProgress,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 200.0,
                      child: FloatingActionButton.extended(
                        elevation: 0,
                        label: Text(
                          'Siguiente',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          widget.breakfastFocusNode.unfocus();
                          widget.lunchFocusNode.unfocus();
                          widget.dinnerFocusNode.unfocus();
                          widget.snackFocusNode.unfocus();
                          if (_addFoodReviewFormKey.currentState!.validate()) {
                            Get.to(
                              () => SelectContactToSendPage(
                                daysToReview: dropdownValue,
                                breakfast: _breakfastController.text,
                                lunch: _lunchController.text,
                                dinner: _dinnerController.text,
                                snack: _snackController.text,
                                currentName: widget.currentName,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _createForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        // _myDropDownWidget(dropdownValue),
        Row(
          children: [
            Text('Resumen de:', style: TextStyle(fontSize: 16.0)),
            Expanded(child: SizedBox()),
            Container(
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Un', 'Tres', 'Cinco', 'Siete']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'días',
              style: TextStyle(fontSize: 16.0),
            )
          ],
        ),

        SizedBox(
          height: 20.0,
        ),
        Text(
          'Desayuno',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        _createBreakfast(),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Almuerzo',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        _createLunch(),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Cena',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        _createDinner(),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Aperitivos',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        _createSnacks(),
      ],
    );
  }

  Widget _createBreakfast() {
    return CustomFormField(
      maxLines: 5,
      isLabelEnabled: false,
      controller: _breakfastController,
      focusNode: widget.breakfastFocusNode,
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.done,
      validator: (value) => Validator.validateField(
        value: value,
      ),
      label: 'Desayuno',
      hint: 'Detalle desayuno',
    );
  }

  Widget _createLunch() {
    return CustomFormField(
      maxLines: 5,
      isLabelEnabled: false,
      controller: _lunchController,
      focusNode: widget.lunchFocusNode,
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.done,
      validator: (value) => Validator.validateField(
        value: value,
      ),
      label: 'Almuerzo',
      hint: 'Detalle Almuerzo',
    );
  }

  Widget _createDinner() {
    return CustomFormField(
      maxLines: 5,
      isLabelEnabled: false,
      controller: _dinnerController,
      focusNode: widget.dinnerFocusNode,
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.done,
      validator: (value) => Validator.validateField(
        value: value,
      ),
      label: 'Cena',
      hint: 'Detalle cena',
    );
  }

  Widget _createSnacks() {
    return CustomFormField(
      maxLines: 5,
      isLabelEnabled: false,
      controller: _snackController,
      focusNode: widget.snackFocusNode,
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.done,
      validator: (value) => Validator.validateField(
        value: value,
      ),
      label: 'Aperitivos',
      hint: 'Detalle aperitivos',
    );
  }
}
