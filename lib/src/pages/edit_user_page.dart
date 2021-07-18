import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';

class EditUserPage extends StatefulWidget {
  // final FocusNode titleFocusNode;
  // final FocusNode descriptionFocusNode;
  final String currentName;
  final String currentweight;
  final String currentheight;
  final String currentage;
  final String documentId;
  const EditUserPage({
    // required this.titleFocusNode,
    // required this.descriptionFocusNode,
    required this.currentName,
    required this.currentweight,
    required this.currentheight,
    required this.currentage,
    required this.documentId,
  });

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _editUserInfoFormKey = GlobalKey<FormState>();
  late String name;
  late String weight;
  late String height;
  late String age;

  bool _isProcessing = false;
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _ageController;

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget.currentName,
    );
    _weightController = TextEditingController(
      text: widget.currentweight,
    );
    _heightController = TextEditingController(
      text: widget.currentheight,
    );
    _ageController = TextEditingController(
      text: widget.currentage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Form(
            key: _editUserInfoFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Header(
                  height: 150.0,
                  userImage: 'images/userPhoto.jpg',
                  backgroundImage: 'images/background.jpg',
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: Column(
                    children: <Widget>[
                      _createName(),
                      SizedBox(height: 20.0),
                      _createWeight(),
                      SizedBox(height: 20.0),
                      _createHeight(),
                      SizedBox(height: 20.0),
                      _createDate(context),
                    ],
                  ),
                ),
                _isProcessing
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            CustomColors.foodpink,
                          ),
                        ),
                      )
                    : Container(
                        child: FloatingActionButton.extended(
                          label: Text('Guardar'),
                          onPressed: () async {
                            if (_editUserInfoFormKey.currentState!.validate()) {
                              setState(() => _isProcessing = true);
                              await DatabaseUser.updateUser(
                                age: _ageController.text,
                                docId: widget.documentId,
                                height: _heightController.text,
                                name: _nameController.text,
                                weight: _weightController.text,
                              );
                              setState(() => _isProcessing = false);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextField _createName() {
    return TextField(
      controller: _nameController,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre',
        icon: Icon(Icons.account_circle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        name = valor;
      },
    );
  }

  TextField _createHeight() {
    return TextField(
      controller: _heightController,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Altura',
        icon: Icon(Icons.height),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        setState(() {
          name = valor;
        });
      },
    );
  }

  TextField _createWeight() {
    return TextField(
      controller: _weightController,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        // counter: Text('${_nombre.length}'),
        labelText: 'Peso',
        icon: Icon(Icons.accessibility),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        setState(() {
          name = valor;
        });
      },
    );
  }

  TextField _createDate(BuildContext context) {
    return TextField(
      controller: _ageController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        labelText: 'Fecha de nacimiento',
        icon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = (await showDatePicker(
      context: context,
      initialDate: new DateTime(1980),
      firstDate: new DateTime(1920),
      lastDate: new DateTime.now(),
      locale: Locale('es', 'ES'),
    ))!;
    age = picked.toString();
    _ageController.text = age;
  }
}

class Header extends StatelessWidget {
  final double height;
  final String userImage;
  final String backgroundImage;
  const Header({
    required this.height,
    required this.userImage,
    required this.backgroundImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(this.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      height: this.height,
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          UserPhoto(
            size: 90.0,
            userImage: this.userImage,
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
              ),
              Icon(Icons.upload_file),
            ],
          )
        ],
      ),
    );
  }
}

class UserPhoto extends StatelessWidget {
  final String userImage;
  final double size;
  const UserPhoto({
    required this.userImage,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/userPhoto.jpg'),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
        border: Border.all(color: CustomColors.foodNavy, width: 4),
      ),
      width: 90.0,
      height: 90.0,
      margin: EdgeInsets.only(bottom: 5.0),
    );
  }
}
