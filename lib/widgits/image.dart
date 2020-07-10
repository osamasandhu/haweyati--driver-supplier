import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
class PickImage extends StatefulWidget {


  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File _image;

  @override



  Widget build(BuildContext context) {




    Future getCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
      });
    }

    Future getGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }



    return  Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: getCamera,
                child: Text("Camera"),
                shape: StadiumBorder(),
                textColor: Colors.white,
                color: Theme
                    .of(context)
                    .accentColor,
              ),
              FlatButton(
                onPressed: getGallery,
                child: Text("Gallery"),
                shape: StadiumBorder(),
                textColor: Colors.white,
                color: Theme
                    .of(context)
                    .accentColor,
              )
            ]
        ),


    SizedBox(height: 10),
    Container(
    height: 200.0,
width: MediaQuery.of(context).size.width,    child: _image == null ? Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(width: 2, color: Theme
        .of(context)
        .accentColor)),
    child: Center(child: Text('No image selected.')))
        : ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: Image.file(
    _image, fit: BoxFit.cover,
    )
    ),
    )





      ],
    );
  }
}
