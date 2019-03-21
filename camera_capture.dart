import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


void main() => runApp(new CameraApp());

class CameraApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp>{
  File _image;

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState((){
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context){
    return new MaterialApp(title: 'Image picker',
    home: new Scaffold(appBar: AppBar(
      title: Text('Image Picker'),
      ),
      body: Center(child: _image == null ? Text('No image selected') : Image.file(_image)),
      floatingActionButton: FloatingActionButton(onPressed: getImage,
      tooltip: 'Pick Image', 
      child: Icon(Icons.camera)),
      ),
      );
  }
}