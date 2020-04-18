import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class TemaBloc extends Bloc<TemaEvent, TemaState> {
  @override
  TemaState get initialState => UygulamaTemasi(tema: ThemeData.light(), renk: Colors.blue);

  @override
  Stream<TemaState> mapEventToState(TemaEvent event) async* {

    UygulamaTemasi uygulamaTemasi;

    if(event is TemaDegistirEvent){
      switch(event.havaDurumuKisaltmasi){
        case "sn" : //KARLI
        case "sl" : //SULU KAR
        case "h" : //DOLU
        case "t" : //fırtına
        case "hc" : //bulutlu
          uygulamaTemasi = UygulamaTemasi(tema: ThemeData(primaryColor:Colors.blueGrey), renk: Colors.grey);
          break;
        case "hr" : //ağır yağmurlu
        case "lr" : //hafif yağmurlu
        case "s" : //sağanak
          uygulamaTemasi = UygulamaTemasi(tema: ThemeData(primaryColor:Colors.indigoAccent), renk: Colors.indigo);
          break;
        case "lc" : //az bulutlu
        case "c" : //açık güneşli hava
          uygulamaTemasi = UygulamaTemasi(tema: ThemeData(primaryColor:Colors.orangeAccent), renk: Colors.yellow);
          break;
      }
      yield uygulamaTemasi;
    }
  }
}
