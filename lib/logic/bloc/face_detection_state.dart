part of 'face_detection_bloc.dart';

sealed class FaceDetectionState extends Equatable {
  const FaceDetectionState();

  @override
  List<Object> get props => [];
}

final class FaceDetectionInitial extends FaceDetectionState {}

final class FaceDetectionReady extends FaceDetectionState {
  final List faces;
  final File? image;

  const FaceDetectionReady({required this.faces,required this.image});

  @override
  List<Object> get props => [faces];
}
