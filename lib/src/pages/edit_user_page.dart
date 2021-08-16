import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditUserPage extends StatefulWidget {
  final String currentName;
  final String currentPhoto;
  final String currentweight;
  final String currentheight;
  final String currentage;
  final String currentEmail;
  final String documentId;
  const EditUserPage({
    required this.currentEmail,
    required this.currentName,
    required this.currentPhoto,
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
  File? sampleImage;
  late String photo;
  late String name;
  late String email;
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
      appBar: AppBar(),
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
                      color: CustomColors.foodNavy,
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
                        icon: Icon(Icons.camera_alt),
                        onPressed: getPhoto,
                      ),
                      IconButton(
                        icon: Icon(Icons.upload_sharp),
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
                              uploadStatusImage(
                                sampleImage!,
                                docId = widget.documentId,
                                age = _ageController.text,
                                name = _nameController.text,
                                email = widget.currentEmail,
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
        ],
      ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = File(tempImage!.path);
      print('file del sample image: $sampleImage');
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

Future<void> uploadStatusImage(
  File sampleImage,
  String docId,
  String age,
  String name,
  String email,
  String weight,
  String height,
) async {
  String url;
  firebase_storage.Reference postImageRef =
      firebase_storage.FirebaseStorage.instance.ref().child(docId);
  print('Image URl' + postImageRef.toString());
  var timeKey = DateTime.now();
  firebase_storage.UploadTask uploadTask =
      postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);
  print('imagen que se subira: ${uploadTask.toString()}');
  var imageUrl = await (await uploadTask).ref.getDownloadURL();
  print('url de la imagen:  $imageUrl');
  url = imageUrl.toString();
  // Guardar el post a firebase database: database realtime database
  await DatabaseUser.updateUser(
    photo: url,
    age: age,
    docId: docId,
    height: height,
    name: name,
    weight: weight,
  );
  await DatabaseUser.addUserOnListUsers(
    photo: url,
    name: name,
    email: email,
    docId: docId,
  );
}
