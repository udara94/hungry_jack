import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_jack/bloc/authentication/authentication_bloc.dart';
import 'package:hungry_jack/bloc/authentication/authentication_event.dart';
import 'package:hungry_jack/bloc/authentication/authentication_state.dart';
import 'package:hungry_jack/resources/colors.dart';
import 'package:hungry_jack/resources/const.dart';
import 'package:hungry_jack/resources/images.dart';
import 'package:hungry_jack/screens/authentication.dart';
import 'package:hungry_jack/screens/home.dart';
import 'package:hungry_jack/screens/welcome.dart';
import 'package:hungry_jack/services/shared_preference.dart';
import '../utils/common.dart';
import 'email_verify.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationEmpty) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(CheckAuthentication());
          } else if (state is AuthenticationValid) {
            Future.delayed(const Duration(seconds: 3), () {
              moveToHomePage(context);
            });
          } else if (state is UnAuthentication) {
            Future.delayed(const Duration(seconds: 3), () {
              moveToWelcomePage(context);
            });
          } else if (state is AuthenticationError) {
            if (kDebugMode) {
              print("Error in firebase authentication");
            }
          }
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
              padding: EdgeInsets.only(bottom: 26, left: 26, right: 26),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text(
                  Const.deliverYourMeal,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ]));
        },
      ),
    );
  }

  moveToWelcomePage(BuildContext context) async {
    bool isWelcomeScreenLoaded =
        await SharedPreferenceService.isWelcomeScreenIsLoaded();
    if (!mounted) return;
    if (isWelcomeScreenLoaded) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AuthenticationPage()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    }
  }

  moveToHomePage(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
