import 'package:flutter/material.dart';
import 'package:food/src/widgets/contact_to_send_list.dart';

class SelectContactToSendPage extends StatefulWidget {
  final String daysToReview;
  final String breakfast;
  final String lunch;
  final String dinner;
  final String snack;
  final String currentName;
  const SelectContactToSendPage({
    required this.daysToReview,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
    required this.currentName,
  });
  @override
  _SelectContactToSendPageState createState() =>
      _SelectContactToSendPageState();
}

class _SelectContactToSendPageState extends State<SelectContactToSendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ContactToSendList(
            daysToReview: widget.daysToReview,
            breakfast: widget.breakfast,
            lunch: widget.lunch,
            dinner: widget.dinner,
            snack: widget.snack,
            currentName: widget.currentName,
          ),
        ),
      ),
    );
  }
}
