import 'package:auto_size_text/auto_size_text.dart';
import 'package:dash_weather/cubits/auth/auth_cubit.dart';
import 'package:dash_weather/presentation/widgets/common_button.dart';
import 'package:dash_weather/utils/constants.dart';
import 'package:dash_weather/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (BuildContext context, Object? state) {},
              builder: (BuildContext context, state) {
                if (state is AuthCompleted) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Gaps.v8,
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.arrowCircleLeft,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          Gaps.h8,
                          AutoSizeText(
                            "Profile",
                            maxLines: 1,
                            minFontSize: 1,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.85),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v8,
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1C48),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 18.0,
                          horizontal: 24.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "Email",
                              minFontSize: 1,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                            AutoSizeText(
                              state.user.email!,
                              minFontSize: 1,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Gaps.v18,
                            Center(
                              child: CommonButton(
                                onPressed: () async {
                                  await context.read<AuthCubit>().logOutUser();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      REGISTRATION_ROUTE, (route) => false);
                                },
                                width: 180.0,
                                text: "Log out",
                              ),
                            ),
                            Gaps.v18,
                          ],
                        ),
                      ),
                    ],
                  );
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
