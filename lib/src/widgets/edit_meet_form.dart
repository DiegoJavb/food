import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/utils/validator.dart';

import 'custom_form_field.dart';

class EditMeetForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;

  //ESTOS SON LOS QUE ME TRAIGO
  final String currentTitle;
  final String currentDescription;
  final String documentId;
  final String contactId;
  const EditMeetForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.currentTitle,
    required this.currentDescription,
    required this.documentId,
    required this.contactId,
  });

  @override
  _EditMeetFormState createState() => _EditMeetFormState();
}

class _EditMeetFormState extends State<EditMeetForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  @override
  void initState() {
    _titleController = TextEditingController(
      text: widget.currentTitle,
    );

    _descriptionController = TextEditingController(
      text: widget.currentDescription,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editItemFormKey,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
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
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _titleController,
                  focusNode: widget.titleFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Asunto',
                  hint: 'Ingrese el Asunto',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Descripción',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
            ),
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
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      width: 200.0,
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.white,
                        label: Text(
                          'Actualizar',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        onPressed: () async {
                          widget.titleFocusNode.unfocus();
                          widget.descriptionFocusNode.unfocus();

                          if (_editItemFormKey.currentState!.validate()) {
                            setState(() => _isProcessing = true);
                            await DatabaseUser.updateContactAppointment(
                              docId: widget.documentId,
                              contactId: widget.contactId,
                              title: _titleController.text,
                              detail: _descriptionController.text,
                            );
                            setState(() => _isProcessing = false);

                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
