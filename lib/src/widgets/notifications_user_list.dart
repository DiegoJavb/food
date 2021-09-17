import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/pages/food_detail_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';

class NotificationUserList extends StatelessWidget {
  final String userId;
  final String role;
  NotificationUserList({
    required this.userId,
    required this.role,
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

              ///datos personales
              String peso = notificationInfo['peso'];
              String estatura = notificationInfo['estatura'];
              String edad = notificationInfo['edad'];

              ///alimentacion
              String desayuno = notificationInfo['desayuno'];
              String almuerzo = notificationInfo['almuerzo'];
              String cena = notificationInfo['cena'];
              String aperitivos = notificationInfo['aperitivos'];
              String dias = notificationInfo['dias'];
              String enviado = notificationInfo['enviado'];
              String evaluacion = notificationInfo['evaluation'];
              return Ink(
                child: _createNotification(
                  peso,
                  estatura,
                  edad,
                  desayuno,
                  almuerzo,
                  cena,
                  aperitivos,
                  dias,
                  enviado,
                  notificationID,
                  evaluacion,
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                CustomColors.foodProgress,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _createNotification(
    String peso,
    String estatura,
    String edad,
    String desayuno,
    String almuerzo,
    String cena,
    String aperitivos,
    String dias,
    String enviado,
    String notificationID,
    String evaluacion,
  ) {
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
            () => FoodDetailPage(
              peso: peso,
              estatura: estatura,
              edad: edad,
              desayuno: desayuno,
              almuerzo: almuerzo,
              cena: cena,
              aperitivos: aperitivos,
              dias: dias,
              enviado: enviado,
              notificationID: notificationID,
              currentEvaluation: evaluacion,
              role: role,
            ),
          );
        },
        title: Text(
          notificationID,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
