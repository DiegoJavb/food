import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/pages/notification_details_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseEvaluations.readPatients(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            padding: EdgeInsets.only(top: 16.0),
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var noteInfo = snapshot.data!.docs[index];
              String userId = snapshot.data!.docs[index].id;
              String name = noteInfo['nombre'];
              String email = noteInfo['email'];
              //El userId y el email son los mismos para todos los usuarios
              return Ink(
                decoration: BoxDecoration(
                  color: CustomColors.firebaseGrey.withOpacity(1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  child: _createNotification(name, email, userId),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _createNotification(String name, String email, userId) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onTap: () {
        Get.to(
          () => NotificationDetailsPage(
            userId: userId,
            userName: name,
          ),
        );
      },
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
