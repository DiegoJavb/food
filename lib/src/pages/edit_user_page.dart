import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditUserPage extends StatefulWidget {
  final String currentName;
  final String currentRole;
  final String currentPhoto;
  final String currentweight;
  final String currentheight;
  final String currentage;
  final String currentEmail;
  const EditUserPage({
    required this.currentEmail,
    required this.currentName,
    required this.currentRole,
    required this.currentPhoto,
    required this.currentweight,
    required this.currentheight,
    required this.currentage,
  });

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _editUserInfoFormKey = GlobalKey<FormState>();
  File? sampleImage;
  late String photo;
  late String nameChecker;
  late String name;
  late String email;
  late String role;
  late String weight;
  late String height;
  late String age;
  late String docId;

  bool _isProcessing = false;
  late TextEditingController _photoController;
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _ageController;

  @override
  void initState() {
    _photoController = TextEditingController(
      text: widget.currentPhoto,
    );
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
      appBar: CustomAppBar(
        title: '',
      ),
      body: ListView(
        children: [
          Form(
            key: _editUserInfoFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 25.0),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CustomColors.foodBackground,
                      width: 2,
                    ),
                  ),
                  // child: _photoController.text == ''
                  child: sampleImage == null
                      ? Container(
                          width: 200,
                          height: 200,
                          child: _photoController.text == ''
                              // child: sampleImage == null
                              ? Center(
                                  child: Text(
                                    widget.currentEmail[0].toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 60.0),
                                  ),
                                )
                              : Container(
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 100.0,
                                      backgroundImage:
                                          NetworkImage(_photoController.text),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                        )
                      : Center(
                          child: CircleAvatar(
                            radius: 100.0,
                            backgroundImage: FileImage(
                              sampleImage!,
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        iconSize: 40.0,
                        icon: Icon(Icons.camera_alt, color: Colors.pink),
                        onPressed: getPhoto,
                      ),
                      IconButton(
                        iconSize: 40.0,
                        icon: Icon(Icons.upload_sharp, color: Colors.blue),
                        onPressed: getImage,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: Column(
                    children: <Widget>[
                      _createName(),
                      SizedBox(height: 20.0),
                      Container(
                        child: Row(children: <Widget>[
                          Container(
                            width: 150.0,
                            child: _createWeight(),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          Text('kilogramos', style: TextStyle(fontSize: 20.0)),
                        ]),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        child: Row(children: <Widget>[
                          Container(
                            width: 150.0,
                            child: _createHeight(),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          Text('Centímetros', style: TextStyle(fontSize: 20.0)),
                        ]),
                      ),
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
                            CustomColors.foodProgress,
                          ),
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 200.0,
                              child: FloatingActionButton.extended(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                label: Text(
                                  'Guardar',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                onPressed: () async {
                                  if (_editUserInfoFormKey.currentState!
                                      .validate()) {
                                    setState(() => _isProcessing = true);
                                    uploadStatusImage(
                                      sampleImage!,
                                      nameChecker = widget.currentName,
                                      docId = widget.currentEmail,
                                      age = _ageController.text,
                                      name = _nameController.text,
                                      email = widget.currentEmail,
                                      role = widget.currentRole,
                                      weight = _weightController.text,
                                      height = _heightController.text,
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
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = File(tempImage!.path);
    });
  }

  Future getPhoto() async {
    var tempImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      sampleImage = File(tempImage!.path);
    });
  }

  TextField _createName() {
    return TextField(
      controller: _nameController,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: CustomColors.foodBackground,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: CustomColors.foodBackground,
          fontSize: 20.0,
        ),
        labelText: 'Nombre',
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
      keyboardType: TextInputType.number,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: CustomColors.foodBackground,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: CustomColors.foodBackground,
          fontSize: 20.0,
        ),
        labelText: 'Altura en Metros',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        setState(() {
          height = valor;
        });
      },
    );
  }

  TextField _createWeight() {
    return TextField(
      controller: _weightController,
      keyboardType: TextInputType.number,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: CustomColors.foodBackground,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: CustomColors.foodBackground,
          fontSize: 20.0,
        ),
        labelText: 'Peso',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        setState(() {
          weight = valor;
        });
      },
    );
  }

  TextField _createDate(BuildContext context) {
    return TextField(
      controller: _ageController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: CustomColors.foodBackground,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: CustomColors.foodBackground,
          fontSize: 20.0,
        ),
        labelText: 'Fecha de nacimiento',
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

Future<void> uploadStatusImage(
  File sampleImage,
  String nameChecker,
  String docId,
  String age,
  String name,
  String email,
  String role,
  String weight,
  String height,
) async {
  String url;

  // Guardar el post a firebase database: database realtime database
  if (nameChecker == '') {
    firebase_storage.Reference postImageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(docId);
    print('nombre si es que hay alguien: $name');
    firebase_storage.UploadTask uploadTask =
        postImageRef.child(email + ".jpg").putFile(sampleImage);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    url = imageUrl.toString();
    await DatabaseUser.addUserInfo(
      photo: url,
      age: age,
      docId: docId,
      height: height,
      name: name,
      email: email,
      weight: weight,
      role: role,
    );
    await DatabaseUser.addUserOnListUsers(
      photo: url,
      name: name,
      email: email,
      role: role,
      docId: docId,
    );
  } else {
    firebase_storage.Reference postImageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(docId);
    print('nombre si es que hay alguien: $name');
    firebase_storage.UploadTask uploadTask =
        postImageRef.child(email + ".jpg").putFile(sampleImage);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    url = imageUrl.toString();
    await DatabaseUser.updateUserInfo(
      photo: url,
      age: age,
      docId: docId,
      height: height,
      name: name,
      email: email,
      weight: weight,
      role: role,
    );
    await DatabaseUser.updateUserOnListUsers(
      photo: url,
      name: name,
      email: email,
      role: role,
      docId: docId,
    );
  }
}
