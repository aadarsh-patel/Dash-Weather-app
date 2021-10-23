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
        desiredAccuracy: LocationAccuracy.low,
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

    const String baseUrl = 'http://api.weatherstack.com';
    const String key = '427e5d7b149000dc207d977ebfda9f8b';

    // final currentWeatherUrl =
    //     "$baseUrl/current?access_key=$key&query=$latitude,$longitude";
    final forecastWeatherUrl =
        "$baseUrl/forecast?access_key=$key&query=$latitude,$longitude&forecast_days=4&hourly=1&interval=24";

    http.Response forecastResponse =
        await http.get(Uri.parse(forecastWeatherUrl));
    var jsonResponse = jsonDecode(forecastResponse.body);
    if (forecastResponse.statusCode == 200) {
      print(jsonResponse);
      var currentWeather = CurrentWeather.fromJson(jsonResponse);
      List<ForecastWeather> forecastWeathers = [];

      jsonResponse['forecast'].forEach((key, value) {
        forecastWeathers.add(ForecastWeather.fromJson(value));
      });

      emit(
        WeatherDataFetched(
          currentWeather: currentWeather,
          forecastWeathers: forecastWeathers,
        ),
      );
    } else {
      print(
        "Can't fetch weather data! Response code: ${forecastResponse.statusCode.toString()}",
      );
    }
  }
}
