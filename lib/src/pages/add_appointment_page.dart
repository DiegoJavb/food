import 'package:flutter/material.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:food/src/widgets/add_item_form.dart';

class AddAppointmentPage extends StatelessWidget {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _contactFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
        _contactFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.foodNavy,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddItemForm(
              titleFocusNode: _titleFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              contactFocusNode: _contactFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
