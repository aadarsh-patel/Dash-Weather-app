import 'package:auto_size_text/auto_size_text.dart';
import 'package:dash_weather/cubits/auth/auth_cubit.dart';
import 'package:dash_weather/presentation/widgets/common_button.dart';
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
  bool _signUpSelected = false;

  InputDecoration _getInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.white,
      ),
      contentPadding: const EdgeInsets.only(
        left: 12.0,
        top: 0.0,
        right: 0.0,
        bottom: 0.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
        borderSide: BorderSide(
          color: Color(0xFF6200ED),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
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
                    Spacer(flex: 1),
                    AutoSizeText(
                      "Welcome to,",
                      minFontSize: 1,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    AutoSizeText(
                      "Dash Weather",
                      minFontSize: 1,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gaps.v18,
                    Image.asset(
                      "assets/app_logo.png",
                      height: 100.0,
                    ),
                    Gaps.v36,
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                _signUpSelected = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 600),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _signUpSelected
                                    ? Colors.white10
                                    : Color(0xFF6200ED),
                                borderRadius: BorderRadius.circular(8.0),
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
                        Gaps.h8,
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                _signUpSelected = true;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 600),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _signUpSelected
                                    ? Color(0xFF6200ED)
                                    : Colors.white10,
                                borderRadius: BorderRadius.circular(8.0),
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
                    Gaps.v18,
                    TextField(
                      controller: _emailController,
                      decoration: _getInputDecoration("Email"),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                    ),
                    Gaps.v18,
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: _getInputDecoration("Password"),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                    ),
                    Gaps.v24,
                    CommonButton(
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
                      width: 180.0,
                      text: "Continue",
                    ),
                    Spacer(flex: 2),
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
