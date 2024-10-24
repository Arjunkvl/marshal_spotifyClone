import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marshal/Presentation/pages/Home%20Page/bloc/Play%20Song%20Cubit/play_song_cubit.dart';
import 'package:marshal/Presentation/pages/Playing%20page/bloc/PlayingPageBloc/playing_page_bloc.dart';
import 'package:marshal/Presentation/pages/Playing%20page/helpers/button_states.dart';
import 'package:marshal/Presentation/pages/Playing%20page/helpers/change_notifier.dart';
import 'package:marshal/data/models/song_model.dart';

class PlayerController extends StatelessWidget {
  final Song song;
  const PlayerController({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PlaySongCubit>().playSong(song: song);
      },
      child: Container(
        width: ScreenUtil().screenWidth - 20,
        height: 45.h,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow()],
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                CachedNetworkImage(
                  imageUrl: song.coverUrl,
                  width: 40,
                ),
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(
                  width: 100.w,
                  child: Text(
                    song.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'cir',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(
                  width: 10.w,
                ),
                IconButton(
                  onPressed: () {
                    if (playButtonState.value == PlayButtonState.paused) {
                      context.read<PlayingPageBloc>().add(PauseSongEvent());
                    }
                    if (playButtonState.value == PlayButtonState.playing) {
                      context.read<PlayingPageBloc>().add(PlaySongEvent());
                    }
                  },
                  icon: ValueListenableBuilder(
                      valueListenable: playButtonState,
                      builder: (context, value, _) {
                        return switch (value) {
                          PlayButtonState.loading =>
                            const CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          PlayButtonState.playing => Icon(
                              Icons.play_arrow,
                              size: 30,
                              color: Colors.black,
                            ),
                          PlayButtonState.paused => Icon(
                              Icons.pause,
                              size: 30,
                              color: Colors.black,
                            ),
                        };
                      }),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
