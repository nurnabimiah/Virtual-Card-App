
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_card_application/models/contact_model.dart';
import 'package:virtual_card_application/pages/new_contact_pages.dart';
import 'package:virtual_card_application/utls/constants.dart';

final selectedLines = [];

class ScanPage extends StatefulWidget {
  static const String routeName ='/scan';

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;
  String name = "",mobile = "",emial = "",address = "",company = "",designation = "",website = "",image = "" ;
  var _lines = <String> [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text('Scan visiting Card'),
        actions: [
          TextButton(
              onPressed:_imagePath == null ? null  : _createContactModelFromScannedValues,
              child: const Text('Next',style: TextStyle(color: Colors.white),)),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: _imagePath==null ?
              Image.asset('images/placeholderimage.jpg',width: double.infinity,height: 200,fit: BoxFit.cover,):
              Image.file(File(_imagePath!),width: double.infinity,height: 200,fit: BoxFit.cover),


            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(Icons.camera),
                  onPressed: (){
                  _imageSource = ImageSource.camera;
                  _takePhoto();
              },

                  label: const Text('Capture Image')),

              TextButton.icon(
                  icon: Icon(Icons.photo_album),

                  onPressed: (){
                    _imageSource = ImageSource.gallery;
                    _takePhoto();
                    },

                  label: const Text('Select from Gallery'))

            ]
          ),
          Column(
            children: _lines.map((e) => LineItem(e)).toList(),
              
          ),
          if(_imagePath!=null) Wrap(
            children: [
              createPropertyButton(ContactProperties.name),
              createPropertyButton(ContactProperties.mobile),
              createPropertyButton(ContactProperties.email),
              createPropertyButton(ContactProperties.address),
              createPropertyButton(ContactProperties.company),
              createPropertyButton(ContactProperties.designation),
              createPropertyButton(ContactProperties.website),

            ],
          )


        ],
      ),


    );
  }

// button create and onclick listener
 Widget createPropertyButton(String name){
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(onPressed: (){
        _getPropertyValue(name);  // method name

      }, child: Text(name)),
    );

 }



  void _takePhoto() async {
  final imageFile = await ImagePicker().pickImage(source: _imageSource);

  if(imageFile != null){
    setState((){
     _imagePath = imageFile.path;
    });
    image = _imagePath!;
    final textReconnizer = GoogleMlKit.vision.textRecognizer();
    final recgnizedText = await textReconnizer.processImage(InputImage.fromFile(File(_imagePath!)));
    final tempList = <String>[];

    for( var block in recgnizedText.blocks){
      for( var line in block.lines){
        tempList.add(line.text);

      }
    }
    setState((){
      _lines = tempList;

    });

  }


  }

  void _getPropertyValue(String name) {
    final mergeText = selectedLines.join(' ');
    switch(name){
      case ContactProperties.name:
        this.name = mergeText;
        break;
      case ContactProperties.mobile:
        mobile = mergeText;
        break;
      case ContactProperties.email:
        emial = mergeText;
        break;
      case ContactProperties.address:
        address = mergeText;
        break;
      case ContactProperties.company:
        company = mergeText;
        break;
      case ContactProperties.designation:
        designation = mergeText;
        break;
      case ContactProperties.website:
        website = mergeText;
        break;

    }
    selectedLines.clear();

  }


  void _createContactModelFromScannedValues() {
    final contact = ContactModel(
      name: name,
      mobile: mobile,
      email: emial,
      address: address,
      company: company,
      designation: designation,
      website: website,
      image: image,

    );

    Navigator.pushNamed(context, NewContactPage.routeName,arguments: contact);
  }
}

class LineItem extends StatefulWidget {
  final String line;
  LineItem(this.line);

  @override
  State<LineItem> createState() => _LineItemState();
}

class _LineItemState extends State<LineItem> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.line),
      trailing: Checkbox(
        value: _isChecked,
        onChanged: ( value) {
          setState((){
           _isChecked = value!;

          });
          value! ? selectedLines.add(widget.line) : selectedLines.remove(widget.line);



        },

      ),
    );
  }
}

