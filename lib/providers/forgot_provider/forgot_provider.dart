import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:tiinver_project/api_services/forgot_password_services/forgot_password_services.dart';
import 'package:tiinver_project/models/forgot_password_model/forgot_password_model.dart';
import 'package:tiinver_project/models/user_login_model/user_login_model.dart';
import 'package:tiinver_project/screens/app_screens/bottom_navbar_screen/bottom_navbar_screen.dart';
import 'package:tiinver_project/screens/auth_screens/onboarding_screen/onboarding_screen.dart';
import 'package:tiinver_project/screens/auth_screens/signin_screen/sign_in_screen.dart';

import '../../api_services/sign_in_api_services/sign_in_api_services.dart';
import '../../db_keys.dart';


class ForgotProvider with ChangeNotifier {

  var emailC = TextEditingController();
  var passwordC = TextEditingController();
  var confirmPasswordC = TextEditingController();

  bool obscureText1 = true;

  bool obscureText2 = true;

  ForgotPasswordModel? _userForgotModel;

  ForgotPasswordModel? get userForgotModel => _userForgotModel;

  bool isLoading = false;

  ForgotPasswordModel? _user;

  final ForgotPasswordApiServices _apiService = ForgotPasswordApiServices();

  ForgotPasswordModel? get user => _user;

  Future<void> forgotPassword() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _apiService.forgotPassword(emailC.text.toString(), passwordC.text.toString());
      _user = ForgotPasswordModel.fromJson(response);
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  hidePassword(){
    obscureText1 = !obscureText1;
    notifyListeners();
  }

  hideConfirmPassword(){
    obscureText2 = !obscureText2;
    notifyListeners();
  }


}
