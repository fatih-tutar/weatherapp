import 'package:flutterweatherappwithbloc/data/weather_api_client.dart';
import 'package:flutterweatherappwithbloc/locator.dart';
import 'package:flutterweatherappwithbloc/model/weather.dart';

class WeatherRepository{

  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();

  Future<Weather> getWeather(String sehir) async{

    final int sehirID = await weatherApiClient.getLocationID(sehir);
    return await weatherApiClient.getWeather(sehirID);

  }
}