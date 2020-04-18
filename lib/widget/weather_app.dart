import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweatherappwithbloc/blocs/bloc.dart';
import 'package:flutterweatherappwithbloc/blocs/theme/bloc.dart';
import 'package:flutterweatherappwithbloc/widget/hava_durumu_resim.dart';
import 'package:flutterweatherappwithbloc/widget/location.dart';
import 'package:flutterweatherappwithbloc/widget/max_min_sicaklik.dart';
import 'package:flutterweatherappwithbloc/widget/sehir_sec.dart';
import 'package:flutterweatherappwithbloc/widget/son_guncelleme.dart';

class WeatherApp extends StatelessWidget {
  String kullanicininSectigiSehir = "Ankara";
  Completer<void> _refreshCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                kullanicininSectigiSehir = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SehirSecWidget()));
                if (kullanicininSectigiSehir != null) {
                  _weatherBloc.add(
                      FetchWeatherEvent(sehirAdi: kullanicininSectigiSehir));
                }
              }),
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          builder: (context, WeatherState state) {
            if (state is InitialWeatherState) {
              return Center(
                child: Text("Şehir seçiniz."),
              );
            } else if (state is WeatherLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoadedState) {
              final getirilenWeather = state.weather;
              final _havaDurumuKisaltma = getirilenWeather.consolidatedWeather[0].weatherStateAbbr;

              BlocProvider.of<TemaBloc>(context).add(TemaDegistirEvent(havaDurumuKisaltmasi: _havaDurumuKisaltma));

              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return RefreshIndicator(
                onRefresh: (){
                  _weatherBloc.add(RefreshWeatherEvent(sehirAdi: kullanicininSectigiSehir));
                  return _refreshCompleter.future;
                },
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: LocationWidget(
                        secilenSehir: getirilenWeather.title,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: SonGuncellemeWidget()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: HavaDurumuResimWidget()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: MaxveMinSicaklikWidget()),
                    ),
                  ],
                ),
              );
            } else if (state is WeatherErrorState) {
              return Center(
                child: Text("Hata oluştu."),
              );
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
