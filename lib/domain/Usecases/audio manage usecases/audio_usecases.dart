import 'dart:io';

import 'package:audiotags/audiotags.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:marshal/domain/repository/Audio%20Manage%20Repo/audio_manage_repo.dart';

class ExtractAudioMetadata {
  final AudioManageRepo repository;
  ExtractAudioMetadata({required this.repository});
  Future<Option<Tag>> call(File audioFile) async {
    return await repository.extractAudioMetadata(audioFile);
  }
}

class UploadAudio {
  final AudioManageRepo repository;
  UploadAudio({required this.repository});
  Future<UploadTask> call(
      {required File audioFile, required songId, required Tag tag}) async {
    return await repository.uploadAudio(
        audioFile: audioFile, songId: songId, tag: tag);
  }
}

class UploadEssentials {
  final AudioManageRepo repository;
  UploadEssentials({required this.repository});
  Future<void> call({required String songId, required Tag tag}) async {
    await repository.uploadEssentials(songId: songId, tag: tag);
  }
}
