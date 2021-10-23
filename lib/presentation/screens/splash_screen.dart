import 'package:dash_weather/cubits/auth/auth_cubit.dart';
import 'package:dash_weather/cubits/weather_data/weather_data_cubit.dart';
import 'package:dash_weather/utils/constants.dart';
import 'package:dash_weather/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _initialize(BuildContext ctx) async {
    var result = await ctx.read<AuthCubit>().checkAuthentication();
    if (result) {
      await ctx.read<WeatherDataCubit>().getLocation();
      Navigator.of(context).pushReplacementNamed(HOME_PAGE_ROUTE);
    } else {
      Navigator.of(context).pushReplacementNamed(REGISTRATION_ROUTE);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initialize(context);
    SizeConfig.init(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF11103A),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.white.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
