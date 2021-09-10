import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/widgets/edit_meet_form.dart';

class EditMeetPage extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String documentId;
  final String contactId;
  const EditMeetPage({
    required this.currentTitle,
    required this.currentDescription,
    required this.documentId,
    required this.contactId,
  });

  @override
  _EditMeetPageState createState() => _EditMeetPageState();
}

class _EditMeetPageState extends State<EditMeetPage> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  ///
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
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Colors.pink,
                    Colors.blue,
                  ])),
            ),
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
              child: EditMeetForm(
                documentId: widget.documentId,
                contactId: widget.contactId,
                titleFocusNode: _titleFocusNode,
                descriptionFocusNode: _descriptionFocusNode,
                currentTitle: widget.currentTitle,
                currentDescription: widget.currentDescription,
              ),
            ),
          ),
        ));
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
                await DatabaseUser.deleteContactAppointment(
                  docId: widget.documentId,
                  contactId: widget.contactId,
                );
                setState(() => _isDeleting = false);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
