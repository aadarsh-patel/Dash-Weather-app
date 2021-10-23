class CurrentWeather {
  final String location;
  final int localTimeEpoch;
  final num temperature;
  final String weatherIcon;
  final String weatherDescription;
  final num humidity;
  final num feelsLike;

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
      location: json['name'] as String,
      localTimeEpoch: json['dt'] as int,
      temperature: json['main']['temp'] as num,
      weatherIcon: json['weather'][0]['icon'] as String,
      weatherDescription: json['weather'][0]['main'] as String,
      humidity: json['main']['humidity'] as num,
      feelsLike: json['main']['feels_like'] as num,
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
