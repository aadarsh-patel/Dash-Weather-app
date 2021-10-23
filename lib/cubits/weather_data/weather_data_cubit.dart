import 'package:bloc/bloc.dart';
import 'package:dash_weather/data/models/forecast_weather.dart';
import 'package:equatable/equatable.dart';

import 'dart:convert';

import 'package:dash_weather/data/models/current_weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

part 'weather_data_state.dart';

class WeatherDataCubit extends Cubit<WeatherDataState> {
  WeatherDataCubit() : super(WeatherDataInitial());

  Future<void> getLocation() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      emit(
        WeatherDataLocation(
          latitude: pos.latitude.toString(),
          longitude: pos.longitude.toString(),
        ),
      );
    } catch (e) {
      emit(WeatherDataError(e.toString()));
    }
  }

  Future<void> fetchData({
    required String latitude,
    required String longitude,
  }) async {
    emit(WeatherDataLoading());

    const String baseUrl = 'https://api.openweathermap.org/data/2.5';
    const String key = 'e8a71f4595684efb76c7f34bda6593ba';

    var currentWeather;
    var forecastWeathers = <ForecastWeather>[];

    final currentUrl =
        "$baseUrl/weather?lat=$latitude&lon=$longitude&units=metric&appid=$key";
    final forecastUrl =
        "$baseUrl/onecall?lat=$latitude&lon=$longitude&exclude=minutely,hourly,alerts&units=metric&appid=$key";

    http.Response currentResponse = await http.get(Uri.parse(currentUrl));
    var currentJson = jsonDecode(currentResponse.body);
    if (currentResponse.statusCode == 200) {
      currentWeather = CurrentWeather.fromJson(currentJson);
    } else {
      print(
        "Can't fetch weather data! Response code: ${currentResponse.statusCode.toString()}",
      );
    }

    http.Response forecastResponse = await http.get(Uri.parse(forecastUrl));
    var forecastJson = jsonDecode(forecastResponse.body);
    if (forecastResponse.statusCode == 200) {
      List<dynamic> temp = forecastJson['daily'];
      temp.forEach((element) {
        forecastWeathers.add(ForecastWeather.fromJson(element));
      });
    } else {
      print(
        "Can't fetch weather data! Response code: ${forecastResponse.statusCode.toString()}",
      );
    }

    emit(
      WeatherDataFetched(
        currentWeather: currentWeather,
        forecastWeathers: forecastWeathers,
      ),
    );
  }
}
