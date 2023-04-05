import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/widgets/custom_text_form_field.dart';

import '../resources/colors.dart';
import '../resources/const.dart';
import '../resources/images.dart';
import '../utilities/common.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
            BoxConstraints(minHeight: CommonUtils.getDeviceHeight(context)),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Column(
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
                    ],
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
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Container(
                              width: CommonUtils.getDeviceWidth(context) * 0.25,
                              height: CommonUtils.getDeviceWidth(context) * 0.25,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(ImagesRepo.appLogo),
                                    fit: BoxFit.contain,
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 30, left: 30, right: 30),
                          child: Center(
                            child: Text(
                              Const.signUp,
                              style: GoogleFonts.anton(
                                  textStyle: const TextStyle(
                                      color: AppColors.black, fontSize: 38)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const CustomTextFormField(
                            text: Const.firstName,
                          hintTextVal: Const.firstName,
                        ),
                        const CustomTextFormField(
                          text: Const.lastName,
                          hintTextVal: Const.lastName,
                        ),
                        const CustomTextFormField(
                          text: Const.email,
                          hintTextVal: Const.email,
                          description: Const.emailVerification,
                        ),
                        const CustomTextFormField(
                          text: Const.mobileNumber,
                          hintTextVal: Const.mobileNumber,
                          description: Const.mobileVerification,
                        ),
                        const CustomTextFormField(
                          text: Const.password,
                          hintTextVal: Const.password,
                          description: Const.passwordDetails,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
