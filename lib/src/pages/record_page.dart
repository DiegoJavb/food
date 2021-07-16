import 'package:flutter/material.dart';
import 'package:food/src/res/custom_colors.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/widgets/item_list.dart';
import 'package:get/get.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: CustomColors.firebaseNavy,
      appBar: AppBar(
        backgroundColor: CustomColors.firebaseNavy,
        title: Text('Historial'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: ItemList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed('addAppointment');
        },
      ),
    );
  }
}
