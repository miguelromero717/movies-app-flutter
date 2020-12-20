const String API_KEY = '781e532a45b12b535e9dbf5c8436b9c2';
const String API_VERSION = '3';
const String URL = 'api.themoviedb.org';
const String LANGUAGE = 'es-ES';
const Map<String, String> ROUTES = {
  'now_playing': API_VERSION + '/movie/now_playing',
  'populars': API_VERSION + '/movie/popular'
};
const String URL_POSTER_IMG = 'https://image.tmdb.org/t/p/w500/';
const String NO_IMAGE = 'assets/img/no-image.jpg';
const String NO_IMAGE_WEB =
    'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59512910-bb6d-0136-46ec-71c445b85d45/e/933395a0-cb1b-0135-a812-525400970412/icons/icon-no-image.svg';
const Map<String, String> LABELS = {'popular': 'Popular Movies'};
