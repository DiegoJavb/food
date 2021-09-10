import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/pages/register_meet_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/widgets/record_contact_list.dart';
import 'package:get/get.dart';

class MyContactDetailPage extends StatelessWidget {
  final String contactName;
  final String contactEmail;
  final String contactPhoto;

  const MyContactDetailPage({
    required this.contactName,
    required this.contactPhoto,
    required this.contactEmail,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('photo del contacto: ${this.contactPhoto}');
    return Scaffold(
      appBar: CustomAppBar(
        title: this.contactName,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10.0),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CustomColors.foodBackground,
                      width: 2,
                    ),
                  ),
                  width: 100.0,
                  height: 100.0,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(this.contactPhoto),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 150.0,
                  child: Text(this.contactEmail),
                ),
                SizedBox(width: 10.0),
                Container(
                  child: Center(
                    child: IconButton(
                      onPressed: () => _createDialog(
                        context,
                        contactEmail,
                      ),
                      icon: Icon(
                        Icons.delete,
                        size: 30.0,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              height: 300.0,
              child: RecordList(contactEmail: this.contactEmail),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(
            () => RegisterMeetPage(
              contactEmail: this.contactEmail,
            ),
          );
        },
      ),
    );
  }
}

void _createDialog(
  BuildContext context,
  String contactEmail,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Desea eliminar este contacto'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Si'),
            onPressed: () {
              DatabaseUser.deleteContact(docId: contactEmail);
              Get.snackbar(
                'Hecho',
                'Su contacto ha sido eliminado',
              );
              Future.delayed(Duration(seconds: 2), () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      );
    },
  );
}
