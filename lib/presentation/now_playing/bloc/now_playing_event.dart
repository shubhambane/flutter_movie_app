part of 'now_playing_bloc.dart';

@immutable
sealed class NowPlayingEvent {}

class FetchNowPlayingEvent extends NowPlayingEvent {}
