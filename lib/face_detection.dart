import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class FaceDetection extends StatefulWidget {
  const FaceDetection({super.key});

  @override
  State<FaceDetection> createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  File? _image;
  List _faces = [];
  Future _pickerImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      setState(() {
        _image = File(image.path);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _detectFaces(File? image) async {
    if (image != null) {
      try {
        final options = FaceDetectorOptions();
        final faceDetector = FaceDetector(options: options);
        final inputImage = InputImage.fromFile(image);

        final faces = await faceDetector.processImage(inputImage);
        setState(() {
          _faces = faces;
        });
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Detection'),
      ),
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                _image == null
                    ? Container(
                        width: double.infinity,
                        height: 480,
                        color: Colors.grey.shade400,
                        child: const Icon(Icons.add_a_photo_sharp),
                      )
                    : Image.file(
                        _image!,
                        height: 300,
                      ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _pickerImage(ImageSource.camera).then((value) => _detectFaces(_image),);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.blue,
                    child: const Center(
                        child: Text("Camera",
                            style: TextStyle(color: Colors.white))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _pickerImage(ImageSource.gallery).then((value) => _detectFaces(_image),);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.blue,
                    child: const Center(
                        child: Text(
                      "choose image from gallery",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("number of people in image : "),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("${_faces.length}"),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
