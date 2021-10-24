import 'package:auto_size_text/auto_size_text.dart';
import 'package:dash_weather/data/models/current_weather.dart';
import 'package:dash_weather/data/models/forecast_weather.dart';
import 'package:dash_weather/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String _getIconLink(String text) {
  return "http://openweathermap.org/img/wn/$text@2x.png";
}

class PrimaryCard extends StatelessWidget {
  final CurrentWeather currentWeather;
  const PrimaryCard(this.currentWeather, {Key? key}) : super(key: key);

  String _formatDate(int epoch) {
    String weekDay = "";
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    switch (dateTime.weekday) {
      case 1:
        weekDay = "Mon";
        break;
      case 2:
        weekDay = "Tue";
        break;
      case 3:
        weekDay = "Wed";
        break;
      case 4:
        weekDay = "Thu";
        break;
      case 5:
        weekDay = "Fri";
        break;
      case 6:
        weekDay = "Sat";
        break;
      case 7:
        weekDay = "Sun";
        break;
    }
    String day = dateTime.day.toString();
    String month = DateFormat.MMM().format(dateTime);
    return "$weekDay, $day $month";
  }

  Widget _getInfo(String title, String description) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AutoSizeText(
          title,
          minFontSize: 1,
          maxLines: 1,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        AutoSizeText(
          description,
          minFontSize: 1,
          maxLines: 1,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1C48),
        borderRadius: BorderRadius.circular(24.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 24.0,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AutoSizeText(
                "Today",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Spacer(flex: 1),
              AutoSizeText(
                _formatDate(currentWeather.localTimeEpoch),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: AutoSizeText(
                  currentWeather.temperature.round().toString(),
                  minFontSize: 1,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    " °C",
                    minFontSize: 1,
                    maxLines: 1,
                    style: TextStyle(
                      color: const Color(0xFFF7C412),
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Spacer(flex: 1),
              Container(
                height: 70,
                width: 70,
                child: Transform.scale(
                  scale: 1.8,
                  child: Image.network(
                    _getIconLink(currentWeather.weatherIcon),
                  ),
                ),
              ),
              Spacer(flex: 1),
              _getInfo(
                "Weather",
                currentWeather.weatherDescription,
              ),
              Spacer(flex: 1),
            ],
          ),
          Gaps.v12,
          Row(
            children: [
              _getInfo(
                "Location",
                currentWeather.location,
              ),
              Spacer(flex: 1),
              _getInfo(
                "Feels like",
                "${currentWeather.feelsLike.round().toString()} °C",
              ),
              Spacer(flex: 1),
              _getInfo(
                "Humidity",
                "${currentWeather.humidity} %",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SecondaryCard extends StatelessWidget {
  final ForecastWeather forecastWeather;
  const SecondaryCard(this.forecastWeather, {Key? key}) : super(key: key);

  String _getWeekDay(int epoch) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    switch (dateTime.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
    }
    return "Error!";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 100,
      margin: EdgeInsets.only(left: 18.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1C48),
        borderRadius: BorderRadius.circular(24.0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 18.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            _getWeekDay(forecastWeather.dateEpoch),
            minFontSize: 1,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          Row(
            children: [
              AutoSizeText(
                forecastWeather.avgTemp.round().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: AutoSizeText(
                  " °C",
                  style: TextStyle(
                    color: const Color(0xFFF7C412),
                    fontSize: 15,
                  ),
                ),
              ),
              Spacer(flex: 2),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Image.network(
                      _getIconLink(forecastWeather.weatherIcon),
                    ),
                  ),
                  AutoSizeText(
                    forecastWeather.weatherDescription,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 1),
            ],
          ),
          Gaps.v8,
          AutoSizeText(
            "Feels like ${forecastWeather.feelsLike.round().toString()} °C",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            minFontSize: 1,
            maxLines: 1,
          ),
          Gaps.v8,
          AutoSizeText(
            "Max temp: ${forecastWeather.maxTemp.toString()} °C",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            minFontSize: 1,
            maxLines: 1,
          ),
          AutoSizeText(
            "Min temp: ${forecastWeather.minTemp.toString()} °C",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            minFontSize: 1,
            maxLines: 1,
          ),
          Gaps.v8,
          AutoSizeText(
            "Humidity: ${forecastWeather.humidity.toString()} %",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            minFontSize: 1,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
