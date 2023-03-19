import 'package:flutter/material.dart';
import 'package:hungry_jack/resources/colors.dart';
import 'package:hungry_jack/resources/const.dart';
import 'package:hungry_jack/resources/images.dart';
import 'package:hungry_jack/screens/welcome.dart';
import 'package:hungry_jack/utilities/common.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      moveToNextPage();
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(children: [
      Container(
        color: AppColors.red,
      ),
      Center(
        child: Container(
          width: CommonUtils.getDeviceWidth(context) * 0.5,
          height: CommonUtils.getDeviceWidth(context) * 0.5,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(ImagesRepo.appLogo),
            fit: BoxFit.contain,
          )),
        ),
      ),
      const Padding(
        padding:  EdgeInsets.only(bottom: 26, left: 26, right: 26),
        child:  Align(
          alignment: FractionalOffset.bottomCenter,
          child:  Text(Const.deliverYourMeal,
            textAlign: TextAlign.center,
            style: TextStyle(
            color: AppColors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),),
        ),
      )
    ]));
  }

  moveToNextPage(){
    Navigator.pushReplacement(
      context,
        MaterialPageRoute(builder:
            (context) =>
            const WelcomeScreen()
        )
    );
  }
}
