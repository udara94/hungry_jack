import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/resources/colors.dart';
import 'package:hungry_jack/resources/const.dart';
import 'package:hungry_jack/screens/login.dart';
import 'package:hungry_jack/screens/signup.dart';

import '../resources/images.dart';
import '../utils/common.dart';
import '../widgets/custom_button.dart';

class AuthenticationPage extends StatefulWidget {
  final fb = FacebookLogin();

  AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final fb = FacebookLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: CommonUtils.getDeviceHeight(context)),
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
                  Column(
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
                            Const.howToContinue,
                            style: GoogleFonts.anton(
                                textStyle: const TextStyle(
                                    color: AppColors.black, fontSize: 27)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            Const.memberReordering,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: CustomButton(
                            onTap: () async {
                              final fb = widget.fb;
                              final res = await fb.logIn(permissions: [
                                FacebookPermission.publicProfile,
                                FacebookPermission.email,
                              ]);

                              if (kDebugMode) {
                                print('Access Token: ${res.status}');
                              }
                            },
                            btnText: Const.continueWithFB,
                            borderRadius: 15,
                            verticalPadding: 10,
                            backgroundColor: AppColors.fbBlue,
                            textColor: AppColors.white,
                            textSize: 24,
                            icon: Icons.facebook,
                            iconColor: AppColors.white,
                            iconSize: 20,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 25),
                          child: CustomButton(
                            onTap: () {
                              moveToLoginPage();
                            },
                            btnText: Const.loginWithEmail,
                            textSize: 24,
                            textColor: AppColors.white,
                            backgroundColor: AppColors.red,
                            verticalPadding: 10,
                            borderRadius: 15,
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 25),
                        child: CustomButton(
                          btnText: Const.signupWithEmail,
                          onTap: () {
                            moveToSignUpPage();
                          },
                          verticalPadding: 10,
                          backgroundColor: AppColors.red,
                          borderRadius: 15,
                          textColor: AppColors.white,
                          textSize: 24,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 30),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            Const.privacyPolicy,
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ))),
        ),
      ),
    );
  }

  moveToLoginPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  moveToSignUpPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpPage()));
  }
}
