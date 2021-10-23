part of 'weather_data_cubit.dart';

abstract class WeatherDataState extends Equatable {
  const WeatherDataState();

  @override
  List<Object> get props => [];
}

class WeatherDataInitial extends WeatherDataState {}

class WeatherDataLoading extends WeatherDataState {}

class WeatherDataLocation extends WeatherDataState {
  final String latitude;
  final String longitude;

  WeatherDataLocation({
    required this.latitude,
    required this.longitude,
  });
}

class WeatherDataError extends WeatherDataState {
  final String error;
  const WeatherDataError(this.error);
}

class WeatherDataFetched extends WeatherDataState {
  final CurrentWeather currentWeather;
  final List<ForecastWeather> forecastWeathers;

  const WeatherDataFetched({
    required this.currentWeather,
    required this.forecastWeathers,
  });
}
