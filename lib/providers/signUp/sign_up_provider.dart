import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiinver_project/api/api_services/api_services.dart';
import 'package:tiinver_project/constant.dart';
import 'package:tiinver_project/routes/routes_name.dart';
import '../../api/endpoint/endpoint.dart';
import '../../api_services/sp_services.dart';
import '../../db_keys.dart';
import '../../models/register/user_sign_up_model.dart';
import '../../screens/app_screens/bottom_navbar_screen/bottom_navbar_screen.dart';

class SignUpProvider extends ChangeNotifier{

  var emailC = TextEditingController();
  var passwordC = TextEditingController();
  var nameC = TextEditingController();
  var confirmPasswordC = TextEditingController();

  bool obscureText1 = true;

  bool obscureText2 = true;

  UserSignUpModel? _userSignUPModel;

  UserSignUpModel? get userSignUPModel => _userSignUPModel;

  String? userApiKey;

  bool isLoading = false;

  UserSignUpModel? _user;

  UserSignUpModel? get user => _user;

  Future<void> signUp() async {
    isLoading = true;
    notifyListeners();
    try {

      final body = {
        'email': emailC.text,
        'password': passwordC.text,
        'firstname': "",
        'lastname': "",
        'phoneNumber': "",
        'username': "",
        'fullname': nameC.text,
        'auth_by_email': 'email',
      };

      final res = await ApiService.post(
          requestBody: postEncode(body),
          headers: headers,
          endPoint: Endpoint.register
      );

      final error = jsonDecode(res.body)["error"];
      if(res.statusCode == 200 || res.statusCode == 201){
        final message = jsonDecode(res.body)["message"];
        log("message: ${res.body}");
        if(error){
          Get.snackbar("error", message);
        }else{
          Get.snackbar("success", message);
         var sp = await SharedPreferencesService.getInstance();
          sp.setString(DbKeys.userApiKey, jsonDecode(res.body)["user"]["apiKey"].toString());
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


  // getUserApiKey()async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   userApiKey = prefs.getString(DbKeys.userApiKey);
  //   debugPrint(userApiKey);
  //   if(userApiKey != null && userApiKey!.isNotEmpty){
  //     Get.to(()=>BottomNavbarScreen());
  //   }else{
  //     Get.to(()=>OnboardingScreen());
  //   }
  //   notifyListeners();
  //}

  hidePassword(){
    obscureText1 = !obscureText1;
    notifyListeners();
  }

  hideConfirmPassword(){
    obscureText2 = !obscureText2;
    notifyListeners();
  }

}