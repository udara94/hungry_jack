import 'package:flutter/cupertino.dart';

class CommonUtils {
  CommonUtils._();

  static double getDeviceHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static double getDeviceWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
}