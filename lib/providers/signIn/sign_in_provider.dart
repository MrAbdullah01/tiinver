import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiinver_project/api_services/sp_services.dart';
import 'package:tiinver_project/screens/app_screens/bottom_navbar_screen/bottom_navbar_screen.dart';
import 'package:tiinver_project/screens/auth_screens/onboarding_screen/onboarding_screen.dart';
import 'package:tiinver_project/screens/auth_screens/signin_screen/sign_in_screen.dart';

import '../../api/api_services/api_services.dart';
import '../../api/endpoint/endpoint.dart';
import '../../constant.dart';
import '../../db_keys.dart';
import '../../models/login/user_login_model.dart';
import '../../routes/routes_name.dart';


class SignInProvider with ChangeNotifier {

  bool obscureText = true;

  String? userApiKey;

  bool isLoading = false;

  UserLoginModel? _user;

  UserLoginModel? get user => _user;

  SignInProvider() {
    loadUserFromPreferences();
  }

  Future<void> loadUserFromPreferences() async {
    var sp = await SharedPreferences.getInstance();
    String? userJson = sp.getString('userModel');
    if (userJson != null) {
      _user = UserLoginModel.fromJson(json.decode(userJson));
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {

      final body = {
        'username': email,
        'password': password,
        'auth_by_email': 'email',
      };

      final res = await ApiService.post(
          requestBody: postEncode(body),
          headers: header1,
          endPoint: Endpoint.login
      );

      if(res.statusCode == 200 || res.statusCode == 201){

        final jsonResponse = jsonDecode(res.body);
        final error = jsonResponse['error'];
        final message = jsonResponse['message'];
        log("message: ${res.body}");

        if(error){
          Get.snackbar("error", message);
        }else{
          Get.snackbar("success", message);
          final user = UserLoginModel.fromJson(jsonResponse);
          var sp = await SharedPreferences.getInstance();
          sp.setString(DbKeys.userApiKey, jsonDecode(res.body)["user"]["apiKey"].toString());
          sp.setString('userModel', json.encode(user.toJson()));
          Get.offAllNamed(RoutesName.bottomNavigationBar);
        }
      }
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

  getUserApiKey()async {
    var  prefs = await SharedPreferencesService.getInstance();
    userApiKey = prefs.getString(DbKeys.userApiKey).toString();
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
