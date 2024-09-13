import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_face_detection/logic/bloc/face_detection_bloc.dart';

class FaceDetection extends StatefulWidget {
  const FaceDetection({super.key});

  @override
  State<FaceDetection> createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaceDetectionBloc, FaceDetectionState>(
      builder: (context, state) {
        if (state is FaceDetectionInitial) {
          BlocProvider.of<FaceDetectionBloc>(context)
              .add(const FaceDetectionInitialEvent());

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is FaceDetectionReady) {
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
                      state.image == null
                          ? Container(
                              width: double.infinity,
                              height: 480,
                              color: Colors.grey.shade400,
                              child: const Icon(Icons.add_a_photo_sharp),
                            )
                          : Image.file(
                              state.image!,
                              height: 300,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<FaceDetectionBloc>(context)
                              .add(const FaceDetectionCameraEvent());
                          
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
                          BlocProvider.of<FaceDetectionBloc>(context)
                              .add(const FaceDetectionGalleryEvent());
                        
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
                          Text("${state.faces.length}"),
                        ],
                      )
                    ],
                  )),
            ),
          );
        }
        return Container();
      },
    );
  }
}
