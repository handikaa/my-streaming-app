class ApiConst {
  static String baseUrl = 'https://api.themoviedb.org';
  static String baseImage = 'https://image.tmdb.org/t/p/w500';
  static String tkn =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNjVmZTI0MjIyMDlmMGU1ZDJhYjY4ODEzMjUzMDRiMCIsIm5iZiI6MTcyNDIzMzY1NC42NzcsInN1YiI6IjY2YzViN2I2YTM1OTkzNTIzZGFmNWQ2NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QxNsQ81CmLMGfpFTTzFsALEZw2WYHNKS1yEgvGXk_fI';

  static String allTrending = '/3/trending/all/day?language=en-US';
  static String movieTrending = '/3/trending/movie/day?language=en-US';
  static String tVTrending = '/3/trending/tv/day?language=en-US';
  static String peopleTrending = '/3/trending/person/day?language=en-US';

  static String listMovieUpcoming = '/3/movie/upcoming?language=en-US&page=1';
  static String detailMovie = '/3/movie';
  static String listMovieNowPlaying =
      '/3/movie/now_playing?language=en-US&page=1';
  static String listMoviePopular = '/3/movie/popular?language=en-US&page=1';
  static String listMovieTopRated = '/3/movie/top_rated?language=en-US&page=1';
  static String searchMovie = '/3/search/movie';

  static String listTvAiring = '/3/tv/airing_today?language=en-US&page=1';
  static String listTvOnAir = '/3/tv/on_the_air?language=en-US&page=1';
  static String listTvPopular = '/3/tv/popular?language=en-US&page=1';
  static String listTvTopRated = '/3/tv/top_rated?language=en-US&page=1';
  static String searchTv = '/3/search/tv';
  static String detailTV = '/3/tv';
}
