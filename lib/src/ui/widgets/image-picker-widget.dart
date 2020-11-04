import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final String previousImage;
  final Function(PickedFile) onImagePicked;
  ImagePickerWidget({this.onImagePicked,this.previousImage});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  PickedFile _image;

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) => Container(
        decoration: BoxDecoration(
          color: Color(0xfff2f2f2f2),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              FlatButton(
                child: Text(lang.camera),
                shape: StadiumBorder(),
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
                onPressed: () async {
                  final image = await ImagePicker().getImage(source: ImageSource.camera);
                  if(image!=null){
                    setState(() {
                      this._image = image;
                    });
                    widget.onImagePicked(image);
                  }
                }
              ),
              FlatButton(
                child: Text(lang.gallery),
                shape: StadiumBorder(),
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
                onPressed: () async {
                  final image = await ImagePicker().getImage(source: ImageSource.gallery);
                  if(image!=null){
                    setState(() {
                      this._image = image;
                    });
                    widget.onImagePicked(image);
                  }
                },
              )
            ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: 200,
                child: _resolveImage(lang),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _resolveImage( lang) {
    if (widget.previousImage == null && _image == null) {
      return Center(
        child: Text(lang.noImageSelected, style: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.bold
        ))
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: _image!=null ? FileImage(File(_image.path)) : NetworkImage(
    HaweyatiService.resolveImage(widget.previousImage),
          )
        ),),
        child: Center(
          child: (widget.previousImage == null && _image == null) ? Text(lang.noImageSelected, style: TextStyle(
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic
          )): Container(
          child: Align(
            alignment: Alignment(.95, -.95),
            child: SizedBox(
              width: 35,
              height: 35,
              child: FlatButton(
                  color: Colors.red,
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.delete, color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  onPressed: () => setState(() => _image = null)
              ),
            ),
          ),
        )
      ));
    }
  }
}