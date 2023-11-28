class MApiConstants {
  //should be another in key file and be git ignored
  static const String mTMDBKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed";

  static const String mNowPlayingApi =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$mTMDBKey";

  static const String mTopRatedApi =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$mTMDBKey";
}
