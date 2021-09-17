import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/pages/notification_details_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';

class NotificationsList extends StatelessWidget {
  final String role;
  const NotificationsList({
    required this.role,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseEvaluations.readContacts(),
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
                child: InkWell(
                  child: _createNotification(name, email, userId),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              CustomColors.foodProgress,
            ),
          ),
        );
      },
    );
  }

  Widget _createNotification(String name, String email, userId) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: CustomColors.foodBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onTap: () {
          Get.to(
            () => NotificationDetailsPage(
              userId: userId,
              userName: name,
              role: this.role,
            ),
          );
        },
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
      ),
    );
  }
}
