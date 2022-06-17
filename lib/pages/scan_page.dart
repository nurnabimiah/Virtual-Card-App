
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  static const String routeName ='/scan';

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text('Scan visiting Card'),
        actions: [
          TextButton(
              onPressed: () {
              },
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
          )

        ],
      ),


    );
  }

  void _takePhoto() async {
  final imageFile = await ImagePicker().pickImage(source: _imageSource);

  if(imageFile != null){
    setState((){
     _imagePath = imageFile.path;
    });
    final textReconnizer = GoogleMlKit.vision.textRecognizer();
    final recgnizedText = await textReconnizer.processImage(InputImage.fromFile(File(_imagePath!)));
    print(recgnizedText.text);
  }


  }

}
