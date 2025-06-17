import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePicker extends StatelessWidget {
  const AppImagePicker({super.key});

  final title = "Selecionador de imagens";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _picker = ImagePicker();
  final _storage = FirebaseStorage.instance.ref("examples/imagePicker");
  XFile? _selectedImage;
  var _uploadingFile = false;
  var _fileUrl = "";

  Future _recoveryImage({bool fromCamera = true}) async {
    final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
    _selectedImage = await _picker.pickImage(source: source);
    setState(() {});
  }

  Future _uploadImage() async {
    // Always replace the image in this project because of the billing
    var task = _storage.child("photo1.jpg").putFile(File(_selectedImage!.path));

    task.snapshotEvents.listen((storageEvent) async {
      if (storageEvent.state == TaskState.running) {
        setState(() {
          _uploadingFile = true;
        });
      } else if (storageEvent.state == TaskState.success) {
        var url = await task.snapshot.ref.getDownloadURL();
        setState(() {
          _fileUrl = url;
          _uploadingFile = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _recoveryImage(),
                  child: Text("Camera"),
                ),
                ElevatedButton(
                  onPressed: () => _recoveryImage(fromCamera: false),
                  child: Text("Gallery"),
                ),
              ],
            ),
            SizedBox(child: Container(height: 10)),
            _uploadingFile ? LinearProgressIndicator() : Container(),
            _selectedImage == null
                ? Container()
                : Image.file(File(_selectedImage!.path)),
            _selectedImage == null
                ? Container()
                : ElevatedButton(
                    onPressed: _uploadImage,
                    child: Text("Upload to firebase"),
                  ),
            Divider(height: 2),
            _fileUrl.isEmpty ? Container() : Image.network(_fileUrl),
          ],
        ),
      ),
    );
  }
}
