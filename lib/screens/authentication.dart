import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/resources/colors.dart';
import 'package:hungry_jack/resources/const.dart';
import 'package:hungry_jack/screens/login.dart';
import 'package:hungry_jack/screens/signup.dart';

import '../resources/images.dart';
import '../utilities/common.dart';

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
                        child: GestureDetector(
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.fbBlue,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.facebook,
                                      size: 25.0, color: AppColors.white),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    Const.continueWithFB,
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
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 25),
                        child: GestureDetector(
                          onTap: () {
                            moveToLoginPage();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.red,
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
                                    Const.loginWithEmail,
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
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 25),
                        child: GestureDetector(
                          onTap: (){
                            moveToSignUpPage();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Const.signupWithEmail,
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
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
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
            ),
          ),
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
