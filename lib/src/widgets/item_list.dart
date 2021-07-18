import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/src/pages/edit_appointment_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:get/get.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            padding: EdgeInsets.only(top: 16.0),
            separatorBuilder: (context, index) => SizedBox(height: 16.0),

            //DESDE AQUI CUENTA EL NUMERO DE DOCUMENTOS EN LA BASE DE DATOS

            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var noteInfo = snapshot.data!.docs[index];
              String docID = snapshot.data!.docs[index].id;
              String title = noteInfo['title'];
              String description = noteInfo['description'];

              return Ink(
                decoration: BoxDecoration(
                  color: CustomColors.firebaseGrey.withOpacity(1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _createItem(title, description, docID),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              CustomColors.foodpink,
            ),
          ),
        );
      },
    );
  }

  Widget _createItem(String title, String description, docID) {
    print(description);
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onTap: () => Get.to(
        () => EditAppointmentPage(
          currentDescription: description,
          currentTitle: title,
          documentId: docID,
        ),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
