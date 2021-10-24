import 'package:auto_size_text/auto_size_text.dart';
import 'package:dash_weather/cubits/weather_data/weather_data_cubit.dart';
import 'package:dash_weather/presentation/widgets/common_button.dart';
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
  void initState() {
    super.initState();
    context.read<WeatherDataCubit>().getLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFF11103A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.safeBlockVertical * 100,
            width: SizeConfig.safeBlockHorizontal * 100,
            padding: EdgeInsets.symmetric(horizontal: 38.0),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/pin.png",
                        height: 140.0,
                      ),
                      Gaps.v36,
                      AutoSizeText(
                        "Allow your location",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Gaps.v8,
                      AutoSizeText(
                        "Upon asking, please give permission to access your location.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      Gaps.v24,
                      CommonButton(
                        onPressed: () async {
                          await context.read<WeatherDataCubit>().getLocation();
                        },
                        width: 180.0,
                        text: "Continue",
                      ),
                    ],
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
