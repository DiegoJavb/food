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
              String contact = noteInfo['contact'];

              return Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _createItem(title, description, contact, docID),
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

  Widget _createItem(String title, String description, String contact, docID) {
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
        onTap: () => Get.to(
          () => EditAppointmentPage(
            currentDescription: description,
            currentTitle: title,
            currentContact: contact,
            documentId: docID,
          ),
        ),
        isThreeLine: true,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '$description\n$contact',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
