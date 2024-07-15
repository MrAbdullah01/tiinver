import 'package:flutter/material.dart';
import 'package:tiinver_project/api_services/forgot_password_services/forgot_password_services.dart';
import '../../models/forgotPassword/forgot_password_model.dart';


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
