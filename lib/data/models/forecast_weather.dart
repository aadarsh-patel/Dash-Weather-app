class ForecastWeather {
  final int dateEpoch;
  final num minTemp;
  final num maxTemp;
  final num avgTemp;
  final String weatherIcon;
  final String weatherDescription;
  final num humidity;
  final num feelsLike;

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
      dateEpoch: json['dt'] as int,
      minTemp: json['temp']['min'] as num,
      maxTemp: json['temp']['max'] as num,
      avgTemp: json['temp']['day'] as num,
      weatherIcon: json['weather'][0]['icon'] as String,
      weatherDescription: json['weather'][0]['main'] as String,
      humidity: json['humidity'] as num,
      feelsLike: json['feels_like']['day'] as num,
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
