import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:id3tag/id3tag.dart';
import 'package:marshal/data/models/song_model.dart';

abstract class AudioManageRepo {
  Future<Option<ID3Tag>> extractAudioMetadata(File audioFile);
  Future<String> generateFileHash({required File file});
  Future<Option<List<Song>>> getSongFromSongIds({required List songIds});
  Future<Option<UploadTask>> uploadAudio(
      {required File audioFile,
      required String songId,
      required ID3Tag tag,
      required String fileHash});
  Future<void> uploadEssentials(
      {required String songId, required ID3Tag tag, required String fileHash});
  Future<void> uploadToRecentSongs({required String songId});
}
