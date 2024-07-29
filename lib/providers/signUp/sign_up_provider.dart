import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiinver_project/api/api_services/api_services.dart';
import 'package:tiinver_project/constant.dart';
import 'package:tiinver_project/providers/signIn/sign_in_provider.dart';
import 'package:tiinver_project/routes/routes_name.dart';
import '../../api/endpoint/endpoint.dart';
import '../../db_keys.dart';
import '../../models/register/user_sign_up_model.dart';
import '../dashboard/dashboard_provider.dart';
import '../suggestions/suggestions_provider.dart';

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

  String? userId;

  bool isLoading = false;

  UserSignUpModel? _user;

  UserSignUpModel? get user => _user;

  Future<void> signUp(BuildContext context) async {
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
          headers: header1,
          endPoint: Endpoint.register
      );

      final error = jsonDecode(res.body)["error"];
      if(res.statusCode == 200 || res.statusCode == 201){

        final jsonResponse = jsonDecode(res.body);
        final error = jsonResponse['error'];
        final message = jsonResponse['message'];
        log("message: ${res.body}");

        if(error){
          Get.snackbar("error", message);
        }else{
          Get.snackbar("success", message);
          final user = UserSignUpModel.fromJson(jsonResponse);
          var sp = await SharedPreferences.getInstance();
          sp.setString(DbKeys.userApiKey, jsonDecode(res.body)["user"]["apiKey"].toString());
          sp.setString(DbKeys.userId, jsonDecode(res.body)["user"]["id"].toString());
          sp.setString(DbKeys.userEmail, jsonDecode(res.body)["user"]["email"].toString());
          sp.setString(DbKeys.userPhone, jsonDecode(res.body)["user"]["phone"].toString());
          Provider.of<SuggestionsProvider>(context, listen: false).fetchSuggestions(
            int.parse(jsonDecode(res.body)["user"]["id"].toString()),
            jsonDecode(res.body)["user"]["apiKey"].toString(),
          );

          Provider.of<DashboardProvider>(context, listen: false).fetchTimeline(
            int.parse(jsonDecode(res.body)["user"]["id"].toString()),
            100,
            0,
            jsonDecode(res.body)["user"]["apiKey"].toString(),
          );
          // sp.setString('userModel', json.encode(user.toJson()));
          Provider.of<SignInProvider>(context,listen: false).
          storeApiKeyAndId(
              userApiKey: jsonDecode(res.body)["user"]["apiKey"].toString(),
              userId: jsonDecode(res.body)["user"]["id"].toString());
          Get.offAllNamed(RoutesName.bottomNavigationBar);
          notifyListeners();
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