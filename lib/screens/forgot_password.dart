import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/resources/colors.dart';
import '../utils/common.dart';
import 'package:hungry_jack/widgets/custom_text_form_field.dart';

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
    AppBar appBar = AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(Const.forgotPassword,
            style: GoogleFonts.anton(
              textStyle: const TextStyle(fontSize: 20, color: AppColors.white),
            )));
    double appBarHeight = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: CommonUtils.getDeviceHeight(context) - appBarHeight),
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
                          Container(
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 30),
                              child: CustomTextFormField(
                                text: Const.email,
                                isSecure: false,
                                onChanged: (){
                                  validateForm();
                                },
                                controller: _emailController,
                                validationMsg: Const.enterValidEmail,
                                hintTextVal: Const.placeholderEmail,
                              )
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: SizedBox(
                        child: Container(),
                      )),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 80, left: 30, right: 30),
                    child: Align(
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
                    ),
                  )
                ],
              ),
            ),
          ),
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
