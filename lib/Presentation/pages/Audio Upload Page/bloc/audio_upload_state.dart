part of 'audio_upload_bloc.dart';

abstract class AudioUploadState extends Equatable {
  const AudioUploadState();

  @override
  List<Object> get props => [];
}

class AudioUploadInitial extends AudioUploadState {}

class UploadErrorState extends AudioUploadState {}

class Uploading extends AudioUploadState {}

class UploadCompletedState extends AudioUploadState {}

class UploadeState extends AudioUploadState {
  final ID3Tag tag;
  final bool isCompleted;
  UploadeState({required this.isCompleted, required this.tag});
  @override
  List<Object> get props => [tag, isCompleted];
}
