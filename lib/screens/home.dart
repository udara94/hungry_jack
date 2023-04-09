import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_jack/bloc/authentication/authentication_bloc.dart';
import 'package:hungry_jack/bloc/authentication/authentication_event.dart';
import 'package:hungry_jack/bloc/authentication/authentication_state.dart';
import 'package:hungry_jack/resources/colors.dart';
import 'package:hungry_jack/resources/const.dart';
import 'package:hungry_jack/screens/authentication.dart';
import 'package:hungry_jack/utils/common.dart';
import 'package:hungry_jack/widgets/custom_button.dart';

import '../widgets/custom_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (BuildContext context, AuthenticationState state) {
              if (state is SignUpInProgress) {
              } else if (state is SignUpCompleted) {
                _moveToAuthenticationPage(context);
              }
            },
            child: Scaffold(
              body: Container(
                color: AppColors.fbBlue,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text(
                        "home page",
                        style: TextStyle(fontSize: 30),
                      ),
                      CustomButton(
                          btnText: "signout",
                          onTap:() {
                            _signOutUser(context);
                      },
                        textSize: 24,
                        backgroundColor: AppColors.red,
                        textColor: AppColors.white,
                      ),
                      const SizedBox(height: 10,),
                      CustomButton(
                        btnText: "show alert",
                        onTap:() {
                        },
                        textSize: 24,
                        backgroundColor: AppColors.red,
                        textColor: AppColors.white,
                      )
                    ],
                  )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _signOutUser(BuildContext context){
    BlocProvider.of<AuthenticationBloc>(context).add(SignOutEvent());
  }

  _moveToAuthenticationPage(BuildContext context){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>  AuthenticationPage()));
  }
}
