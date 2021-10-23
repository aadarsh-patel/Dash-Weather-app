import 'package:flutter/material.dart';

import 'package:dash_weather/utils/constants.dart';

import 'package:dash_weather/presentation/screens/home.dart';
import 'package:dash_weather/presentation/screens/profile.dart';
import 'package:dash_weather/presentation/screens/registration.dart';
import 'package:dash_weather/presentation/screens/select_location.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => Registration(),
        );
      case SELECT_LOCATION_ROUTE:
        return MaterialPageRoute(
          builder: (_) => SelectLocation(),
        );
      case HOME_PAGE_ROUTE:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case PROFILE_ROUTE:
        return MaterialPageRoute(
          builder: (_) => ProfilePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Registration(),
        );
    }
  }
}
