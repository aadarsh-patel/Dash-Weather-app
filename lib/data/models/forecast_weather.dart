class ForecastWeather {
  final int dateEpoch;
  final int minTemp;
  final int maxTemp;
  final int avgTemp;
  final String weatherIcon;
  final String weatherDescription;
  final int humidity;
  final int feelsLike;

  ForecastWeather({
    required this.dateEpoch,
    required this.minTemp,
    required this.maxTemp,
    required this.avgTemp,
    required this.weatherIcon,
    required this.weatherDescription,
    required this.humidity,
    required this.feelsLike,
  });

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
      dateEpoch: json['date_epoch'] as int,
      minTemp: json['mintemp'] as int,
      maxTemp: json['maxtemp'] as int,
      avgTemp: json['avgtemp'] as int,
      weatherIcon: json['hourly'][0]['weather_icons'][0] as String,
      weatherDescription:
          json['hourly'][0]['weather_descriptions'][0] as String,
      humidity: json['hourly'][0]['humidity'][0] as int,
      feelsLike: json['hourly'][0]['feelslike'][0] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateEpoch': dateEpoch,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
      'avgTemp': avgTemp,
      'weatherIcon': weatherIcon,
      'weatherDescription': weatherDescription,
      'humidity': humidity,
      'feelsLike': feelsLike,
    };
  }
}
