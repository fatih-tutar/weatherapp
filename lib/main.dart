import 'package:flutter/material.dart';
import 'package:flutterweatherappwithbloc/blocs/bloc.dart';
import 'package:flutterweatherappwithbloc/blocs/theme/bloc.dart';
import 'package:flutterweatherappwithbloc/locator.dart';
import 'package:flutterweatherappwithbloc/widget/weather_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupLocator();
  runApp(BlocProvider<TemaBloc>(
      create: (context) => new TemaBloc(),
      child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TemaBloc>(context),
      builder: (context, TemaState state) => MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: (state as UygulamaTemasi).tema,
        home: BlocProvider<WeatherBloc>(
            create: (context) => new WeatherBloc(), child: WeatherApp()),
      ),
    );
  }
}
