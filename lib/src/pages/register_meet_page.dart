import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/utils/validator.dart';
import 'package:food/src/widgets/custom_form_field.dart';

class RegisterMeetPage extends StatefulWidget {
  final String contactEmail;
  const RegisterMeetPage({
    required this.contactEmail,
    Key? key,
  }) : super(key: key);

  @override
  _RegisterMeetPageState createState() => _RegisterMeetPageState();
}

class _RegisterMeetPageState extends State<RegisterMeetPage> {
  FocusNode descriptionFocusNode = FocusNode();
  final _addItemFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: Form(
        key: _addItemFormKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: createForm(),
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
                        width: 200.0,
                        height: 50.0,
                        child: ElevatedButton(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Agregar',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            descriptionFocusNode.unfocus();
                            if (_addItemFormKey.currentState!.validate()) {
                              setState(() => _isProcessing = true);
                              await DatabaseUser.addContactAppointment(
                                email: widget.contactEmail,
                                detail: _descriptionController.text,
                              );
                              setState(() => _isProcessing = false);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget createForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

  Widget _createDescription() {
    return CustomFormField(
      maxLines: 10,
      isLabelEnabled: false,
      controller: _descriptionController,
      focusNode: descriptionFocusNode,
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.done,
      validator: (value) => Validator.validateField(
        value: value,
      ),
      label: 'Description',
      hint: 'Detalle del asunto',
    );
  }
}
