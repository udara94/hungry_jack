import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferenceService._();

  static const String _isWelcomeScreenLoaded = "PingRegistered";

  ///save welcome screen loaded in  shared preference
  static Future<void> setWelcomeScreenIsLoaded(bool isRegistered) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(_isWelcomeScreenLoaded, isRegistered);
  }

  /// get welcome screen is loaded from the shared preference
  static Future<bool> isWelcomeScreenIsLoaded() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? status = preferences.getBool(_isWelcomeScreenLoaded);
    if (status != null && status) {
      return true;
    } else {
      return false;
    }
  }
}
