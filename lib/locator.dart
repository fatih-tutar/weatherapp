import 'package:flutterweatherappwithbloc/data/weather_api_client.dart';
import 'package:flutterweatherappwithbloc/data/weather_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator(){
  locator.registerLazySingleton(() => WeatherRepository());
  locator.registerLazySingleton(() => WeatherApiClient());
}