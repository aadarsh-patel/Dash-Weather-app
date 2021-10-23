class CurrentWeather {
  final String location;
  final int localTimeEpoch;
  final int temperature;
  final String weatherIcon;
  final String weatherDescription;
  final int humidity;
  final int feelsLike;

  CurrentWeather({
    required this.location,
    required this.localTimeEpoch,
    required this.temperature,
    required this.weatherIcon,
    required this.weatherDescription,
    required this.humidity,
    required this.feelsLike,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      location: json['location']['name'] as String,
      localTimeEpoch: json['location']['localtime_epoch'] as int,
      temperature: json['current']['temperature'] as int,
      weatherIcon: json['current']['weather_icons'][0] as String,
      weatherDescription: json['current']['weather_descriptions'][0] as String,
      humidity: json['current']['humidity'] as int,
      feelsLike: json['current']['feelslike'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'localTime': localTimeEpoch,
      'temperature': temperature,
      'weatherIcon': weatherIcon,
      'description': weatherDescription,
      'humidity': humidity,
      'feelslike': feelsLike,
    };
  }

  @override
  String toString() {
    return "location: $location, temperature: $temperature, humidity: $humidity";
  }
}
