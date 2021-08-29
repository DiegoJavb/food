import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';

class RecordList extends StatelessWidget {
  final String contactEmail;

  RecordList({required this.contactEmail});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseUser.readContactAppointment(contactId: contactEmail),
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
                // String docID = snapshot.data!.docs[index].id;
                String date = noteInfo['date'];
                String description = noteInfo['name'];
                print(date);
                return Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _createItem(description, date),
                );
              },
            );
          }
          return Center();
        });
  }

  Widget _createItem(String description, String date) {
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
        title: Text(
          description,
        ),
        subtitle: Text(
          date,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
