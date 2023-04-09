import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/bloc/authentication/authentication_bloc.dart';
import 'package:hungry_jack/bloc/authentication/authentication_event.dart';
import 'package:hungry_jack/bloc/authentication/authentication_state.dart';
import 'package:hungry_jack/resources/colors.dart';
import '../utils/common.dart';
import 'package:hungry_jack/widgets/custom_text_form_field.dart';

import '../resources/const.dart';
import '../widgets/custom_alert.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(Const.forgotPassword,
            style: GoogleFonts.anton(
              textStyle: const TextStyle(fontSize: 20, color: AppColors.white),
            )));
    double appBarHeight = appBar.preferredSize.height;
    return BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (BuildContext context, AuthenticationState state) {
              if (state is ResetPasswordInProgress) {
              } else if (state is ResetPasswordCompleted) {
                _showAlertDialog(context);
              } else if (state is ResetPasswordError) {
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
              appBar: appBar,
              body: Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: CommonUtils.getDeviceHeight(context) -
                            appBarHeight),
                    child: IntrinsicHeight(
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                color: AppColors.black,
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 20),
                                    child: Text(
                                      Const.forgotPasswordDescription,
                                      style: TextStyle(
                                          color: AppColors.white, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 30),
                                      child: CustomTextFormField(
                                        text: Const.email,
                                        isSecure: false,
                                        onChanged: () {
                                          validateForm();
                                        },
                                        controller: _emailController,
                                        validationMsg: Const.enterValidEmail,
                                        hintTextVal: Const.placeholderEmail,
                                      )),
                                ],
                              ),
                              Expanded(
                                  child: SizedBox(
                                child: Container(),
                              )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 80, left: 30, right: 30),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () {
                                  _isButtonEnable
                                      ? _resetPassword(context)
                                      : {};
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _isButtonEnable
                                        ? AppColors.black
                                        : AppColors.lightAsh,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Const.send,
                                          style: GoogleFonts.anton(
                                              textStyle: const TextStyle(
                                                  fontSize: 24,
                                                  color: AppColors.white)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
        EmailValidator.validate(_emailController.text)) {
      setState(() {
        _isButtonEnable = true;
      });
    } else {
      setState(() {
        _isButtonEnable = false;
      });
    }
  }

  _resetPassword(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(ResetPassword(_emailController.text));
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return  CustomAlert(
          body: Const.pleaseCheckEmail,
          btnText: Const.ok,
          title: Const.emailSent,
          onTap: (){
            Navigator.pop(context);
          },
        );
      },
    )
        .then((value) {
      CommonUtils.hideKeyBoard(context);
      Navigator.pop(context);
    }
    );
  }
}
