import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:marshal/Presentation/pages/Main%20Home%20Page/bloc/Player%20Controller%20Cubit/player_controller_cubit.dart';
import 'package:marshal/Presentation/pages/Playing%20page/helpers/button_states.dart';
import 'package:marshal/Presentation/pages/Playing%20page/helpers/change_notifier.dart';
import 'package:marshal/Presentation/pages/Playing%20page/helpers/variables.dart';
import 'package:marshal/application/dependency_injection.dart';
import 'package:marshal/data/models/song_model.dart';

part 'playing_page_event.dart';
part 'playing_page_state.dart';

/*
this is the bloc which is reponsible for communicating to the 
audio handler.from here we will call functions defined in the handler.
*/

class PlayingPageBloc extends Bloc<PlayingPageEvent, PlayingPageState> {
  final AudioHandler _audioHandler = locator<AudioHandler>();
  PlayingPageBloc() : super(PlayingPageInitial()) {
    /*
    listening for playback state changes and updating ui accordingly
    */
    _audioHandler.playbackState.listen((playbackState) async {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonState.value = PlayButtonState.loading;
      } else if (!isPlaying) {
        playButtonState.value = PlayButtonState.playing;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonState.value = PlayButtonState.paused;
      }
    });
    on<AddSongEvent>((event, emit) async {
      final Box<Song> box = await Hive.openBox('songsBox');
      if (!box.values.contains(event.song)) {
        await box.add(event.song);
      }
      final mediaItem = MediaItem(
        id: '0',
        title: event.song.title,
        artUri: Uri.parse(event.song.coverUrl),
        artist: event.song.artist,
        extras: {'songId': event.song.songId, 'songUrl': event.song.songUrl},
      );
      int indexOfSong = _audioHandler.queue.value
          .indexWhere((m) => m.extras!['songId'] == event.song.songId);

      if (indexOfSong == -1) {
        await _audioHandler.addQueueItems([mediaItem]);
        indexOfSong = _audioHandler.queue.value
            .indexWhere((m) => m.extras!['songId'] == event.song.songId);
      }

      if (!(_audioHandler.mediaItem.value!.extras!['songId'] ==
          event.song.songId)) {
        _audioHandler.skipToQueueItem(indexOfSong);
      }
      _audioHandler.play();
      log('blocked');
      add(UpdatePlayingPageEvent(song: event.song));
    });

    //Other Events;
    on<PlaySongEvent>((event, emit) async {
      await _audioHandler.play();
    });
    on<PauseSongEvent>((event, emit) async {
      await _audioHandler.pause();
    });
    on<SeekEvent>((event, emit) async {
      await _audioHandler.seek(event.position);
    });
    on<UpdatePlayingPageEvent>((event, emit) {
      locator<PlayerControllerCubit>().showPlayerController(song: event.song);
      emit(PlayingPageInitial());
      emit(PlayingState(song: event.song));
    });
    on<SkipToNextEvent>((event, emit) async {
      final Box<Song> box = await Hive.openBox('songsBox');
      final MediaItem lastMediaItem = _audioHandler.queue.value.last;
      final MediaItem currentItem = _audioHandler.mediaItem.value!;
      if (lastMediaItem.extras!['songId'] == currentItem.extras!['songId']) {
        await addNextSong();
      }
      await _audioHandler.skipToNext();
      add(UpdatePlayingPageEvent(
          song: box.values
              .where((song) =>
                  _audioHandler.mediaItem.value!.extras!['songId'] ==
                  song.songId)
              .toList()
              .first));
    });
    on<SkipToPrevious>((event, emit) async {
      final Box<Song> box = await Hive.openBox('songsBox');
      await _audioHandler.skipToPrevious();
      final Song song = box.values
          .where((song) =>
              _audioHandler.mediaItem.value!.extras!['songId'] == song.songId)
          .toList()
          .first;
      add(UpdatePlayingPageEvent(song: song));
    });
  }

  Future<void> addNextSong() async {
    final Box<Song> box = await Hive.openBox('songsBox');
    if (_audioHandler.queue.value.length == box.values.length) return;
    Song song = box.values.toList()[++index];
    final MediaItem mediaItem = MediaItem(
      id: '0',
      title: song.title,
      artUri: Uri.parse(song.coverUrl),
      artist: song.artist,
      extras: {'songId': song.songId, 'songUrl': song.songUrl},
    );

    if (_audioHandler.queue.value
        .where((m) => m.extras!['songId'] == song.songId)
        .isNotEmpty) {
      await addNextSong();
    }
    await _audioHandler.addQueueItems([mediaItem]);
  }
}
