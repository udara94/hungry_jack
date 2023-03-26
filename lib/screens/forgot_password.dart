import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/resources/colors.dart';
import 'package:hungry_jack/utilities/common.dart';

import '../resources/const.dart';

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
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.black,
          centerTitle: true,
          title: Text(Const.forgotPassword,
              style: GoogleFonts.anton(
                textStyle:
                    const TextStyle(fontSize: 20, color: AppColors.white),
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.black,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text(
                    Const.forgotPasswordDescription,
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              height: CommonUtils.getDeviceHeight(context) * 0.85,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Stack(
                  children: [
                    Column(
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
                    Align(
                      alignment: Alignment.bottomCenter,
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
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
}
