import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:marshal/Presentation/pages/Auth/AuthCheckPage/cubit/auth_status_checking_cubit.dart';
import 'package:marshal/Presentation/pages/Home%20Page/bloc/HomePageBloc/home_page_bloc.dart';
import 'package:marshal/Presentation/pages/Playing%20page/bloc/PlayingPageBloc/playing_page_bloc.dart';
import 'package:marshal/application/authRepo/auth_repo.dart';
import 'package:marshal/application/authUsecases/auth_usecases.dart';
import 'package:marshal/data/repository/Audio%20Manage%20Repo/audio_manage_impl.dart';
import 'package:marshal/data/repository/song_repo_impl.dart';
import 'package:marshal/domain/Usecases/audio%20manage%20usecases/audio_usecases.dart';
import 'package:marshal/domain/Usecases/usecases.dart';
import 'package:marshal/domain/repository/shared_song_repo.dart';
import 'package:marshal/domain/repository/shared_url_repo.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  SharedSongRepo sharedSongRepo = SharedSongRepo();
  SharedUrlRepo sharedUrlRepo = SharedUrlRepo();
  SongRepoImpl repository = SongRepoImpl();
  AuthRepo authRepo = AuthRepo();
  AudioManageImpl audioManageRepo = AudioManageImpl();

  //HomePage Bloc Injection
  locator.registerSingleton<HomePageBloc>(HomePageBloc(
      sharedSongRepo: sharedSongRepo, sharedUrlRepo: sharedUrlRepo));
  //playing page Bloc Injection
  locator.registerSingleton<PlayingPageBloc>(PlayingPageBloc(
      sharedSongRepo: sharedSongRepo, sharedUrlRepo: sharedUrlRepo));

  //Usecases;
  locator.registerSingleton<GetNewReleseas>(
      GetNewReleseas(repository: repository));
  locator.registerSingleton<GenerateSongUrls>(
      GenerateSongUrls(repository: repository));
  locator.registerSingleton<AddSongstoPlayList>(
      AddSongstoPlayList(repository: repository));

  locator
      .registerSingleton<GetUserSignedUp>(GetUserSignedUp(authRepo: authRepo));
  locator.registerSingleton<UserSignIn>(UserSignIn(authRepo: authRepo));

  locator.registerSingleton<AuthStatusCheckingCubit>(
    AuthStatusCheckingCubit(SchedulerBinding.instance),
  );
  locator.registerSingleton<ExtractAudioMetadata>(
      ExtractAudioMetadata(repository: audioManageRepo));
  locator
      .registerSingleton<UploadAudio>(UploadAudio(repository: audioManageRepo));
  locator.registerSingleton<UploadEssentials>(
      UploadEssentials(repository: audioManageRepo));
}
