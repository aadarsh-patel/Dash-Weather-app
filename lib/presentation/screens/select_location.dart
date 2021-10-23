import 'package:dash_weather/cubits/weather_data/weather_data_cubit.dart';
import 'package:dash_weather/utils/constants.dart';
import 'package:dash_weather/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.safeBlockVertical * 100,
            width: SizeConfig.safeBlockHorizontal * 100,
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: BlocConsumer<WeatherDataCubit, WeatherDataState>(
              listener: (context, state) {
                if (state is WeatherDataError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                } else if (state is WeatherDataLocation) {
                  print("${state.latitude}, ${state.longitude}");
                  Navigator.of(context).pushNamed(HOME_PAGE_ROUTE);
                }
              },
              builder: (context, state) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await context.read<WeatherDataCubit>().getLocation();
                    },
                    child: Text("Get location"),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
