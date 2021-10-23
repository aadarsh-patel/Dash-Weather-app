import 'package:auto_size_text/auto_size_text.dart';
import 'package:dash_weather/cubits/auth/auth_cubit.dart';
import 'package:dash_weather/utils/constants.dart';
import 'package:dash_weather/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _signUpSelected = true;

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
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                  // Scaffold.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text(state.message),
                  //   ),
                  // );
                } else if (state is AuthCompleted) {
                  Navigator.of(context).pushNamed(SELECT_LOCATION_ROUTE);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Gaps.v36,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  _signUpSelected = false;
                                }),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 600),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: _signUpSelected
                                        ? Colors.white10
                                        : Colors.white24,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      "Login",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  _signUpSelected = true;
                                }),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 600),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: _signUpSelected
                                        ? Colors.white24
                                        : Colors.white10,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      "Signup",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white24,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(14.0),
                              bottomRight: Radius.circular(14.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 19.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _emailController,
                                ),
                                Gaps.v18,
                                TextField(
                                  controller: _passwordController,
                                ),
                                Gaps.v24,
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_signUpSelected) {
                                      context.read<AuthCubit>().signUpUser(
                                            _emailController.text,
                                            _passwordController.text,
                                          );
                                    } else {
                                      context.read<AuthCubit>().logInUser(
                                            _emailController.text,
                                            _passwordController.text,
                                          );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    child: Text("Continue"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
