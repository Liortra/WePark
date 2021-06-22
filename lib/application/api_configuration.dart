class ApiConfiguration{
  // flutter pub run build_runner build
  // flutter pub run build_runner watch
  // flutter pub run build_runner build --delete-conflicting-outputs
  static const BASE_URL = 'https://spring-wepark.herokuapp.com/';
  static const DOMAIN = 'WePark';
  static const HEADERS = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
}