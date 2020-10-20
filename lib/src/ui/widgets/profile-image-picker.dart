import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class ProfileImagePicker extends StatefulWidget {
  final String previousImage;
  final Function (String) onImagePicked;
  ProfileImagePicker({this.previousImage,this.onImagePicked});
  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Stack(fit: StackFit.loose, children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 110.0,
              height: 110.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).accentColor,width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: _image == null
                    ? widget.previousImage!=null
                    ? Image.network(HaweyatiService.convertImgUrl(widget.previousImage))
                    : Icon(
                  CupertinoIcons.person_solid,
                  color: Theme.of(context).primaryColor,
                  size: 55,
                )
                    : Image.file(_image),
              ),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(top: 60.0, left: 86.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    File tempImage;
                    try {
                      tempImage = await FilePicker.getFile(
                        type: FileType.image,
                      );
                      print(tempImage);
                      if(tempImage!=null){
                        setState(() {
                          _image = tempImage;
                          widget.onImagePicked(tempImage.path);
                        });
                      }

                    } catch (e) {
                      print(e.message);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    height: 35,
                    width: 35,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
