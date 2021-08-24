import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';

class ContactToSendList extends StatefulWidget {
  final String daysToReview;
  final String breakfast;
  final String lunch;
  final String dinner;
  final String snack;
  final String currentName;
  ContactToSendList({
    required this.breakfast,
    required this.daysToReview,
    required this.lunch,
    required this.dinner,
    required this.snack,
    required this.currentName,
  }) : super();
  @override
  _ContactToSendListState createState() => _ContactToSendListState();
}

class _ContactToSendListState extends State<ContactToSendList> {
  String name = '';
  String currentUser = Database.userUid!;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseUser.readMyContacts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('No se ha podido cargar los usuarios');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            padding: EdgeInsets.only(top: 16.0),
            separatorBuilder: (context, index) => SizedBox(
              height: 16.0,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var userInfo = snapshot.data!.docs[index];
              String userId = snapshot.data!.docs[index].id;
              String email = userInfo['email'];
              userInfo['name'] == null ? name = '' : name = userInfo['name'];
              return Ink(
                decoration: BoxDecoration(
                  color: CustomColors.firebaseGrey.withOpacity(1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  child: _createUser(userId, email, name),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: CustomColors.foodBackground,
          ),
        );
      },
    );
  }

  Widget _createUser(String userId, String email, String name) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onTap: () => _createDialog(
        context,
        email,
        widget.daysToReview,
        widget.breakfast,
        widget.lunch,
        widget.dinner,
        widget.snack,
        widget.currentName,
      ),
      leading: Icon(Icons.person),
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        email,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

void _createDialog(
  BuildContext context,
  String email,
  String daysToReview,
  String breakfast,
  String lunch,
  String dinner,
  String snack,
  String currentName,
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
            Text('Esta a punto de enviar este detalle alimenticio a:\n'),
            Text('$email', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('\nDesea Continuar?\n'),
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
              DatabaseEvaluations.addFood(
                days: daysToReview,
                breakfast: breakfast,
                lunch: lunch,
                dinner: dinner,
                snack: snack,
                toUser: email,
              );
              DatabaseEvaluations.addContact(
                fromUser: currentName,
                emailFromUser: Database.userUid!,
                toUser: email,
              );
              Get.snackbar(
                'Envio',
                'Su registro se ha enviado con éxito',
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
