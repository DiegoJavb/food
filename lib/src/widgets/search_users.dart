// import 'dart:ui';

import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {
  final String name;
  final ValueChanged<String> onChanged;
  const SearchUser({
    Key? key,
    required this.name,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchUser> {
  final _userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.name.isEmpty ? styleHint : styleActive;
    return Container(
      height: 40.0,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Flexible(
        child: TextField(
          controller: _userController,
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: style.color),
            suffixIcon: widget.name.isNotEmpty
                ? GestureDetector(
                    child: Icon(Icons.close, color: style.color),
                    onTap: () {
                      _userController.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : null,
            hintText: 'Buscar usuario',
            hintStyle: style,
            border: InputBorder.none,
          ),
          style: style,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
