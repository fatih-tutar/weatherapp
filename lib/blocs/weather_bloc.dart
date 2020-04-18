import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterweatherappwithbloc/data/weather_repository.dart';
import 'package:flutterweatherappwithbloc/locator.dart';
import 'package:flutterweatherappwithbloc/model/weather.dart';
import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepository weatherRepository = locator<WeatherRepository>();

  @override
  WeatherState get initialState => InitialWeatherState();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if(event is FetchWeatherEvent){
      yield WeatherLoadingState();
      try{
        //HAVA DURUMUNU GETİRME KODLARI
        final Weather getirilenWeather = await weatherRepository.getWeather(event.sehirAdi);
        yield WeatherLoadedState(weather : getirilenWeather);
      }catch(e){
        yield WeatherErrorState();
      }
    }else if(event is RefreshWeatherEvent){
      try{
        //HAVA DURUMUNU GETİRME KODLARI
        final Weather getirilenWeather = await weatherRepository.getWeather(event.sehirAdi);
        yield WeatherLoadedState(weather : getirilenWeather);
      }catch(_){
        yield initialState;
      }
    }
  }
}
