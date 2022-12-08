import 'package:advanced_flutter/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String USER_LOGGED_IN = "USER_LOGGED_IN";
const String ONBOARDING_SCREEN_VIEWED = "ONBOARDING_SCREEN_VIEWED";
class AppPreferences{
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future getAppLanguage() async{
    String language = _sharedPreferences.getString(PREFS_KEY_LANG);

    if(language != null && language.isNotEmpty){
      return language;
    }
    else{
      return LanguageType.ENGLISH.getValue();
    }
  }

 Future<void> setOnBoardingScreenViewed() async{
    _sharedPreferences.setBool(ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async{
    return _sharedPreferences.getBool(ONBOARDING_SCREEN_VIEWED) ??false;
  }

  Future<void> setUserLoggedIn() async{
    _sharedPreferences.setBool(USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async{
    return _sharedPreferences.getBool(USER_LOGGED_IN) ?? false ;
  }
}