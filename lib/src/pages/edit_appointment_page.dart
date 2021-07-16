import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/widgets/edit_item_form.dart';
import 'package:get/get.dart';

class EditAppointmentPage extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String documentId;
  EditAppointmentPage(
      {required this.currentTitle,
      required this.currentDescription,
      required this.documentId});

  @override
  _EditAppointmentPageState createState() => _EditAppointmentPageState();
}

class _EditAppointmentPageState extends State<EditAppointmentPage> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  bool _isDeleting = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.firebaseNavy,
          actions: [
            _isDeleting
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[400],
                      size: 32,
                    ),
                    onPressed: () => _showAlert(context),
                  ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditItemForm(
              documentId: widget.documentId,
              titleFocusNode: _titleFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              currentTitle: widget.currentTitle,
              currentDescription: widget.currentDescription,
            ),
          ),
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Realmente quiere eliminar este registro'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () async {
                setState(() => _isDeleting = true);
                await Database.deleteItem(
                  docId: widget.documentId,
                );
                setState(() => _isDeleting = false);
                Get.toNamed('record');
              },
            )
          ],
        );
      },
    );
  }
}
