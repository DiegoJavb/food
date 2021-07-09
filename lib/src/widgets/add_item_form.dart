import 'package:flutter/material.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/utils/database.dart';
import 'package:food/src/utils/validator.dart';
// import 'package:flutterfire_samples/utils/database.dart';

import 'custom_form_field.dart';

class AddItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;

  const AddItemForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
  });
  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
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
              bottom: 24.0,
            ),
            child: _crearForm(),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.firebaseOrange,
                    ),
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'ADD ITEM',
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

                      if (_addItemFormKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.addItem(
                          title: _titleController.text,
                          description: _descriptionController.text,
                        );

                        setState(() {
                          _isProcessing = false;
                        });

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
        SizedBox(height: 24.0),
        Text(
          'Title',
          style: TextStyle(
            // color: CustomColors.firebaseGrey,
            fontSize: 22.0,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        CustomFormField(
          isLabelEnabled: false,
          controller: _titleController,
          focusNode: widget.titleFocusNode,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.next,
          validator: (value) => Validator.validateField(
            value: value,
          ),
          label: 'Title',
          hint: 'Enter your note title',
        ),
        SizedBox(height: 24.0),
        Text(
          'Description',
          style: TextStyle(
            // color: CustomColors.firebaseGrey,
            fontSize: 22.0,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        CustomFormField(
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
          hint: 'Enter your note description',
        ),
      ],
    );
  }
}
