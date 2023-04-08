import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/bloc/authentication/authentication_bloc.dart';
import 'package:hungry_jack/bloc/authentication/authentication_event.dart';
import 'package:hungry_jack/bloc/authentication/authentication_state.dart';
import 'package:hungry_jack/resources/const.dart';
import 'package:hungry_jack/screens/forgot_password.dart';
import 'package:hungry_jack/widgets/custom_button.dart';
import 'package:hungry_jack/widgets/custom_snack_bar.dart';

import '../resources/colors.dart';
import '../widgets/custom_text_form_field.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isButtonEnable = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool _isPasswordSecure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (BuildContext context, AuthenticationState state) {
              if (state is SignInInProgress) {
              } else if (state is SignInComplete) {
                _moveToHomePage(context);
              } else if (state is SignInError) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  SnackBar snackBar = SnackBar(
                    content: Text(
                      state.error,
                      style:
                          const TextStyle(fontSize: 12, color: AppColors.white),
                    ),
                    backgroundColor: AppColors.red,
                    duration: const Duration(milliseconds: 2000),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              }
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      color: AppColors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        color: AppColors.white,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 50, left: 10),
                        child:
                            Icon(Icons.close, size: 35.0, color: AppColors.ash),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 100, left: 30, right: 30),
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Text(
                                Const.login,
                                style: GoogleFonts.anton(
                                    textStyle: const TextStyle(
                                        fontSize: 40, color: AppColors.black)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: CustomTextFormField(
                                isSecure: false,
                                text: Const.email,
                                onChanged: () {
                                  validateForm();
                                },
                                controller: _emailController,
                                validationMsg: Const.enterValidEmail,
                                hintTextVal: Const.placeholderEmail,
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                  text: Const.password,
                                  hintTextVal: Const.password,
                                  isSecure: _isPasswordSecure,
                                  controller: _passwordController,
                                  onChanged: () {
                                    validateForm();
                                  },
                                  suffixIcon: Icons.remove_red_eye_outlined,
                                  suffixIconColor: AppColors.red,
                                  onSuffixIconTap: () {
                                    setState(() {
                                      _isPasswordSecure = !_isPasswordSecure;
                                    });
                                  },
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40),
                                    child: CustomButton(
                                      btnText: Const.login,
                                      onTap: () {
                                        _isButtonEnable
                                            ? _signInUser(context)
                                            : {};
                                      },
                                      backgroundColor: _isButtonEnable
                                          ? AppColors.black
                                          : AppColors.lightAsh,
                                      borderRadius: 15,
                                      verticalPadding: 10,
                                      textColor: AppColors.white,
                                      textSize: 24,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Text(
                                          Const.forgotPassword,
                                          style: GoogleFonts.anton(
                                              textStyle: const TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationThickness: 2,
                                                  fontSize: 20,
                                                  color: AppColors.ash)),
                                          textAlign: TextAlign.center,
                                        ),
                                        onTap: () {
                                          moveToForgotPasswordPage();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  validateForm() {
    if (_emailController.text != "" &&
        EmailValidator.validate(_emailController.text) &&
        _passwordController.text != "") {
      setState(() {
        _isButtonEnable = true;
      });
    } else {
      setState(() {
        _isButtonEnable = false;
      });
    }
  }

  moveToForgotPasswordPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
  }

  _moveToHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false,
    );
  }

  _signInUser(BuildContext context) async {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(SignInUser(_emailController.text, _passwordController.text));
  }
}
