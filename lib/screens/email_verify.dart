import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/bloc/profile/profile_bloc.dart';
import 'package:hungry_jack/bloc/profile/profile_event.dart';
import 'package:hungry_jack/bloc/profile/profile_state.dart';
import 'package:hungry_jack/models/user.dart';
import 'package:hungry_jack/screens/faq.dart';

import '../resources/colors.dart';
import '../resources/const.dart';
import '../resources/images.dart';
import '../utils/common.dart';
import '../widgets/custom_button.dart';
import 'package:sprintf/sprintf.dart';

import 'login.dart';

class EmailVerifyPage extends StatefulWidget {
  const EmailVerifyPage({Key? key}) : super(key: key);

  @override
  State<EmailVerifyPage> createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  String? _email = "";
  bool _isEmailVerified = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (BuildContext context) => ProfileBloc(),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
          if (state is ProfileEmpty) {
            BlocProvider.of<ProfileBloc>(context).add(LoadUserProfile());
          } else if (state is ProfileLoaded) {
            UserProfile user = state.profile;
            _email = user.email ?? "";
          }else if(state is VerifyEmailCompleted){
            _isEmailVerified = true;
            Navigator.pop(context);
          }else if(state is VerifyEmailError){
            _isEmailVerified = false;
          }
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
                         Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(top: 50, left: 10),
                              child: Icon(Icons.close,
                                  size: 35.0, color: AppColors.ash),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Container(
                                  width: CommonUtils.getDeviceWidth(context) *
                                      0.25,
                                  height: CommonUtils.getDeviceWidth(context) *
                                      0.25,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(ImagesRepo.appLogo),
                                    fit: BoxFit.contain,
                                  )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 30, right: 30),
                              child: Center(
                                child: Text(
                                  Const.verifyEmail,
                                  style: GoogleFonts.anton(
                                      textStyle: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 27)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Text(
                                  sprintf(
                                      Const.verificationDescription, [_email]),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            _isEmailVerified ?const SizedBox() :Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  color: AppColors.lightRed,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                    child: Text(
                                      Const.unableToVerify,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12, color: AppColors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 25),
                                child: CustomButton(
                                  onTap: () {
                                    _checkEmailVerification(context);
                                  },
                                  btnText: Const.verifiedEmail,
                                  textSize: 20,
                                  textColor: AppColors.white,
                                  backgroundColor: AppColors.red,
                                  verticalPadding: 10,
                                  borderRadius: 15,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 25),
                              child: CustomButton(
                                btnText: Const.sendAnotherEmail,
                                onTap: () {

                                },
                                verticalPadding: 10,
                                backgroundColor: AppColors.red,
                                borderRadius: 15,
                                textColor: AppColors.white,
                                textSize: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children:  [
                                  const Text(
                                    Const.changeEmail,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.transparent,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      shadows: [
                                        Shadow(
                                            offset: Offset(0, -3),
                                            color: AppColors.mediumAsh)
                                      ],
                                      decorationColor: AppColors.lightAsh,
                                      decorationThickness: 5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      _moveToFAQPage(context);
                                    },
                                    child: const Text(
                                      Const.needHelp,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.transparent,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        shadows: [
                                          Shadow(
                                              offset: Offset(0, -3),
                                              color: AppColors.mediumAsh)
                                        ],
                                        decorationColor: AppColors.lightAsh,
                                        decorationThickness: 5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ))),
              ),
            ),
          );
        },
      ),
    );
  }

  _checkEmailVerification(BuildContext context){
    BlocProvider.of<ProfileBloc>(context).add(CheckEmailVerified());
  }

  _moveToFAQPage(BuildContext context){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FAQPage()));
  }
}
