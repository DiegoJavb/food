import 'package:flutter/material.dart';
import 'package:food/src/widgets/add_foods_review.dart';

class AddFoodToSendPage extends StatelessWidget {
  final FocusNode _breakfastFocusNode = FocusNode();
  final FocusNode _lunchFocusNode = FocusNode();
  final FocusNode _dinnerFocusNode = FocusNode();
  final FocusNode _snackFocusNode = FocusNode();
  final String currentName;

  AddFoodToSendPage({required this.currentName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _breakfastFocusNode.unfocus();
        _lunchFocusNode.unfocus();
        _dinnerFocusNode.unfocus();
        _snackFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: AddFoodsReview(
              currentName: this.currentName,
              breakfastFocusNode: _breakfastFocusNode,
              lunchFocusNode: _lunchFocusNode,
              dinnerFocusNode: _dinnerFocusNode,
              snackFocusNode: _snackFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
