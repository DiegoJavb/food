import 'package:flutter/material.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/utils/validator.dart';
// import 'package:flutterfire_samples/utils/database.dart';

import 'custom_form_field.dart';

class AddItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode contactFocusNode;

  const AddItemForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.contactFocusNode,
  });
  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addItemFormKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 15.0,
            ),
            child: _crearForm(),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.foodProgress,
                    ),
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'Registrar cita',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          // color: CustomColors.firebaseGrey,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      widget.titleFocusNode.unfocus();
                      widget.descriptionFocusNode.unfocus();
                      widget.contactFocusNode.unfocus();

                      if (_addItemFormKey.currentState!.validate()) {
                        setState(() => _isProcessing = true);
                        await Database.addItem(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          contact: _contactController.text,
                        );
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

  Widget _crearForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        Text(
          'Asunto',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        _createTitle(),
        SizedBox(height: 20.0),
        Text(
          'Contacto',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        _createContact(),
        SizedBox(height: 20.0),
        Text(
          'Detalle',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        _createDescription(),
      ],
    );
  }

  Widget _createTitle() {
    return CustomFormField(
      isLabelEnabled: false,
      controller: _titleController,
      focusNode: widget.titleFocusNode,
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.next,
      validator: (value) => Validator.validateField(
        value: value,
      ),
      label: 'Title',
      hint: 'Ingrese el asunto',
    );
  }

  Widget _createDescription() {
    return CustomFormField(
      maxLines: 10,
      isLabelEnabled: false,
      controller: _descriptionController,
      focusNode: widget.descriptionFocusNode,
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.done,
      validator: (value) => Validator.validateField(
        value: value,
      ),
      label: 'Description',
      hint: 'Detalle del asunto',
    );
  }

  Widget _createContact() {
    return CustomFormField(
      isLabelEnabled: false,
      controller: _contactController,
      focusNode: widget.contactFocusNode,
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.done,
      validator: (value) => Validator.validateField(
        value: value,
      ),
      label: 'Nutricionista',
      hint: 'Ingrese el nombre del nutricionista',
    );
  }
}
