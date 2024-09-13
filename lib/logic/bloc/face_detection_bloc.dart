import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

part 'face_detection_event.dart';
part 'face_detection_state.dart';

class FaceDetectionBloc extends Bloc<FaceDetectionEvent, FaceDetectionState> {
  File? _image;
  List _faces = [];
  FaceDetectionBloc() : super(FaceDetectionInitial()) {
    on<FaceDetectionEvent>((event, emit) async {
      try {
        if (event is FaceDetectionCameraEvent) {
          //=================
          try {
            final image =
                await ImagePicker().pickImage(source: ImageSource.camera);
            if (image == null) {
              return;
            }

            _image = File(image.path);
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
          if (_image != null) {
            try {
              final options = FaceDetectorOptions();
              final faceDetector = FaceDetector(options: options);
              final inputImage = InputImage.fromFile(_image!);

              final faces = await faceDetector.processImage(inputImage);

              _faces = faces;
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
          }
          //=================
          emit(FaceDetectionReady(faces: _faces, image: _image));
        }
        if (event is FaceDetectionGalleryEvent) {
        //=================
          try {
            final image =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (image == null) {
              return;
            }

            _image = File(image.path);
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
          if (_image != null) {
            try {
              final options = FaceDetectorOptions();
              final faceDetector = FaceDetector(options: options);
              final inputImage = InputImage.fromFile(_image!);

              final faces = await faceDetector.processImage(inputImage);

              _faces = faces;
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
          }
          //=================
        
          emit(FaceDetectionReady(faces: _faces, image: _image));
        }
        if (event is FaceDetectionInitialEvent) {
          emit(FaceDetectionReady(faces: _faces, image: _image));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }
}
