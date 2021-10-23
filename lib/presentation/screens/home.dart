import 'package:dash_weather/cubits/weather_data/weather_data_cubit.dart';
import 'package:dash_weather/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFF11103A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: BlocConsumer<WeatherDataCubit, WeatherDataState>(
              listener: (context, state) {
                if (state is WeatherDataError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is WeatherDataLocation) {
                  context.read<WeatherDataCubit>().fetchData(
                        latitude: state.latitude,
                        longitude: state.longitude,
                      );
                }
                if (state is WeatherDataLoading) {
                  return CircularProgressIndicator();
                }
                if (state is WeatherDataError) {
                  return Container();
                }

                if (state is WeatherDataFetched) {
                  return Container();
                }

                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
