import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
//import path_provider and complete.......
class InputImage extends StatefulWidget {
  @override
  _InputImageState createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
File storageFile;
Future<void> _takeImage()async{
  final _imageFile=await ImagePicker.pickImage(source: ImageSource.camera,maxWidth: 600);
  if(_imageFile==null)return;
setState(() {
storageFile=_imageFile;
});

}
  @override
  Widget build(BuildContext context) {
    return Row(
   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'chose image',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        RaisedButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: () {},
          icon: Icon(Icons.camera),
          label: Text('take',style: TextStyle(color: Theme.of(context).primaryColor),),
          color: Colors.white,
          elevation: 0.0,
        )
      ],
    );
  }
}
