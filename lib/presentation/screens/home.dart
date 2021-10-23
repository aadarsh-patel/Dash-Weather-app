import 'package:auto_size_text/auto_size_text.dart';
import 'package:dash_weather/cubits/weather_data/weather_data_cubit.dart';
import 'package:dash_weather/presentation/widgets/custom_cards.dart';
import 'package:dash_weather/utils/constants.dart';
import 'package:dash_weather/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

              if (state is WeatherDataFetched) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v8,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        children: [
                          AutoSizeText(
                            "Dash Weather",
                            maxLines: 1,
                            minFontSize: 1,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.85),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(flex: 1),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(PROFILE_ROUTE);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.userCircle,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v18,
                    PrimaryCard(state.currentWeather),
                    Gaps.v24,
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: AutoSizeText(
                        "Next 4 days",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Gaps.v24,
                    Container(
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.forecastWeathers.length - 4,
                        padding: const EdgeInsets.only(right: 18.0),
                        itemBuilder: (BuildContext context, int index) {
                          return SecondaryCard(
                            state.forecastWeathers[index + 1],
                          );
                        },
                      ),
                    ),
                    Gaps.v36,
                  ],
                );
              }

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
            },
          ),
        ),
      ),
    );
  }
}
