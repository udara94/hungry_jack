import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/bloc/authentication/authentication_bloc.dart';
import 'package:hungry_jack/bloc/authentication/authentication_event.dart';
import 'package:hungry_jack/bloc/authentication/authentication_state.dart';
import 'package:hungry_jack/models/user.dart';
import 'package:hungry_jack/screens/email_verify.dart';
import 'package:hungry_jack/screens/home.dart';
import 'package:hungry_jack/widgets/custom_text_form_field.dart';

import '../resources/colors.dart';
import '../resources/const.dart';
import '../resources/images.dart';
import '../utils/common.dart';
import '../widgets/custom_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool _isPasswordSecure = true;
  bool _isButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state){
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (BuildContext context, AuthenticationState state){
              if(state is SignUpInProgress){

              }else if(state is SignUpError){

              }else if(state is SignUpCompleted){
                WidgetsBinding.instance!
                    .addPostFrameCallback((timeStamp) {
                      switchToHome(context);
                });
              }
            },
            child: Scaffold(
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
                           Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 50, left: 10),
                                child:
                                Icon(Icons.close, size: 35.0, color: AppColors.ash),
                              ),
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
                                      height:
                                      CommonUtils.getDeviceWidth(context) * 0.25,
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
                                      top: 10, left: 30, right: 30),
                                  child: Center(
                                    child: Text(
                                      Const.signUp,
                                      style: GoogleFonts.anton(
                                          textStyle: const TextStyle(
                                              color: AppColors.black, fontSize: 30)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                CustomTextFormField(
                                  text: Const.firstName,
                                  hintTextVal: Const.firstName,
                                  isSecure: false,
                                  controller: _firstNameController,
                                  keyboardType: TextInputType.name,
                                  onChanged: () {
                                    validateForm();
                                  },
                                ),
                                CustomTextFormField(
                                  text: Const.lastName,
                                  hintTextVal: Const.lastName,
                                  isSecure: false,
                                  controller: _lastNameController,
                                  keyboardType: TextInputType.name,
                                  onChanged: () {
                                    validateForm();
                                  },
                                ),
                                CustomTextFormField(
                                  text: Const.email,
                                  hintTextVal: Const.email,
                                  description: Const.emailVerification,
                                  isSecure: false,
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validationMsg: Const.enterValidEmail,
                                  onChanged: () {
                                    validateForm();
                                  },
                                ),
                                CustomTextFormField(
                                  text: Const.mobileNumber,
                                  hintTextVal: Const.mobileNumber,
                                  description: Const.mobileVerification,
                                  isSecure: false,
                                  controller: _mobileController,
                                  keyboardType: TextInputType.phone,
                                  onChanged: () {
                                    validateForm();
                                  },
                                ),
                                CustomTextFormField(
                                  controller: _passwordController,
                                  text: Const.password,
                                  hintTextVal: Const.password,
                                  description: Const.passwordDetails,
                                  isSecure: _isPasswordSecure,
                                  onChanged: () {
                                    validateForm();
                                  },
                                  suffixIconColor: AppColors.red,
                                  suffixIcon: Icons.remove_red_eye_outlined,
                                  onSuffixIconTap: () {
                                    setState(() {
                                      _isPasswordSecure = !_isPasswordSecure;
                                    });
                                  },
                                ),
                                CustomButton(
                                  btnText: Const.next,
                                  onTap: () {
                                    _isButtonEnable? _signUpUser(context): {};
                                  },
                                  textSize: 24,
                                  textColor: AppColors.white,
                                  backgroundColor: _isButtonEnable
                                      ? AppColors.red
                                      : AppColors.lightAsh,
                                  verticalPadding: 10,
                                  borderRadius: 15,
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  _signUpUser(BuildContext context)async{
    UserProfile user = UserProfile(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        mobile: _mobileController.text,
        password: _passwordController.text
    );
    BlocProvider.of<AuthenticationBloc>(context).add(SignUpUser(user));
  }

  validateForm() {
    if (_firstNameController.text != "" &&
        _lastNameController.text != "" &&
        _emailController.text != "" &&
        EmailValidator.validate(_emailController.text) &&
        _mobileController.text != "" &&
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

  switchToHome(BuildContext context){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false,
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const EmailVerifyPage()));
  }
}
