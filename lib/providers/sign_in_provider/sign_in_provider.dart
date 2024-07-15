import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiinver_project/models/user_login_model/user_login_model.dart';
import 'package:tiinver_project/screens/app_screens/bottom_navbar_screen/bottom_navbar_screen.dart';
import 'package:tiinver_project/screens/auth_screens/onboarding_screen/onboarding_screen.dart';
import 'package:tiinver_project/screens/auth_screens/signin_screen/sign_in_screen.dart';

import '../../api_services/sign_in_api_services/sign_in_api_services.dart';
import '../../db_keys.dart';


class SignInProvider with ChangeNotifier {

  bool obscureText = true;

  UserLoginModel? _userLoginModel;
  UserLoginModel? get userLoginModel => _userLoginModel;

  UserSignIn userApiKeys = UserSignIn();

  String? userApiKey;

  bool isLoading = false;

  UserLoginModel? _user;
  final SignInApiServices _apiService = SignInApiServices();

  UserLoginModel? get user => _user;

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _apiService.login(email, password);
      _user = UserLoginModel.fromJson(response);
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  logout()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(DbKeys.userApiKey, "");
    Get.offAll(()=>SignInScreen());
    notifyListeners();
  }

  storeUserApiKey()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(DbKeys.userApiKey, _apiService.data["user"]["apiKey"] ?? "");
    Get.offAll(()=>BottomNavbarScreen());
    notifyListeners();
  }

  getUserApiKey()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userApiKey = prefs.getString(DbKeys.userApiKey);
    debugPrint(userApiKey);
    if(userApiKey != null && userApiKey!.isNotEmpty){
      Get.to(()=>BottomNavbarScreen());
    }else{
      Get.to(()=>OnboardingScreen());
    }
    notifyListeners();
  }

  hidePassword(){
    obscureText = !obscureText;
    notifyListeners();
  }


}
