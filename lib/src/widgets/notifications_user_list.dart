import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/pages/food_detail_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';

class NotificationUserList extends StatelessWidget {
  final String userId;
  NotificationUserList({
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    print('el usuario que quiero ver su notifi: ${this.userId}');
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseEvaluations.readNotificationId(this.userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            padding: EdgeInsets.only(top: 16.0),
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var notificationInfo = snapshot.data!.docs[index];
              String notificationID = snapshot.data!.docs[index].id;
              String desayuno = notificationInfo['desayuno'];
              String almuerzo = notificationInfo['almuerzo'];
              String cena = notificationInfo['cena'];
              String aperitivos = notificationInfo['aperitivos'];
              String dias = notificationInfo['dias'];
              String enviado = notificationInfo['enviado'];
              String evaluacion = notificationInfo['evaluation'];
              return Ink(
                decoration: BoxDecoration(
                  color: CustomColors.firebaseGrey.withOpacity(1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _createNotification(desayuno, almuerzo, cena, aperitivos,
                    dias, enviado, notificationID, evaluacion),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createNotification(
      String desayuno,
      String almuerzo,
      String cena,
      String aperitivos,
      String dias,
      String enviado,
      String notificationID,
      String evaluacion) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onTap: () {
        Get.to(
          () => FoodDetailPage(
              desayuno: desayuno,
              almuerzo: almuerzo,
              cena: cena,
              aperitivos: aperitivos,
              dias: dias,
              enviado: enviado,
              notificationID: notificationID,
              currentEvaluation: evaluacion),
        );
      },
      leading: Icon(Icons.notification_important),
      title: Text(
        notificationID,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
