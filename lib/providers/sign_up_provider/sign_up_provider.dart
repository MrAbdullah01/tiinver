import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiinver_project/api_services/sign_up_api_services/sign_up_api_services.dart';

import '../../db_keys.dart';
import '../../models/user_sign_up_model/user_sign_up_model.dart';
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
  final SignUpApiServices _apiService = SignUpApiServices();

  UserSignUpModel? get user => _user;

  Future<void> signUp() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _apiService.signUp(emailC.text, passwordC.text, nameC.text);
      _user = UserSignUpModel.fromJson(response);
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  storeUserApiKey()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(DbKeys.userApiKey, _apiService.data["user"]["apiKey"]);
    Get.offAll(()=>BottomNavbarScreen());
    notifyListeners();
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