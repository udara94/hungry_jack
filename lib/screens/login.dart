import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/resources/const.dart';
import 'package:hungry_jack/screens/forgot_password.dart';

import '../resources/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isButtonEnable = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
              child: Icon(Icons.close, size: 35.0, color: AppColors.ash),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          Const.email,
                          style: TextStyle(color: AppColors.ash),
                        ),
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            onChanged: (val) {
                              validateForm();
                            },
                            controller: _emailController,
                            validator: (value) =>
                                EmailValidator.validate(value ?? "")
                                    ? null
                                    : Const.enterValidEmail,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.black, width: 2.0)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.0, color: AppColors.black)),
                                hintText: Const.placeholderEmail,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.lightAsh)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          Const.password,
                          style: TextStyle(color: AppColors.ash),
                        ),
                        TextFormField(
                          obscureText: _isPasswordVisible,
                          onChanged: (val) {
                            validateForm();
                          },
                          controller: _passwordController,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                child: const Icon(Icons.remove_red_eye_outlined,
                                    color: AppColors.red),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.black, width: 2.0)),
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.0, color: AppColors.black)),
                              hintText: Const.password,
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lightAsh)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: _isButtonEnable
                                    ? AppColors.black
                                    : AppColors.lightAsh,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Const.login,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Text(
                                  Const.forgotPassword,
                                  style: GoogleFonts.anton(
                                      textStyle: const TextStyle(
                                          decoration: TextDecoration.underline,
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
            ),
          )
        ],
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
}
