part of 'face_detection_bloc.dart';

sealed class FaceDetectionEvent extends Equatable {
  const FaceDetectionEvent();

  @override
  List<Object> get props => [];
}

class FaceDetectionCameraEvent extends FaceDetectionEvent {
  const FaceDetectionCameraEvent();
  

}

class FaceDetectionGalleryEvent extends FaceDetectionEvent {
  const FaceDetectionGalleryEvent();
}

class FaceDetectionInitialEvent extends FaceDetectionEvent {
  const FaceDetectionInitialEvent();
}
