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
import '../../api_services/sign_in_api_services/sign_in_api_services.dart';
import '../../constant.dart';
import '../../db_keys.dart';
import '../../models/login/user_login_model.dart';
import '../../routes/routes_name.dart';


class UpdateProfileProvider with ChangeNotifier {


  bool isLoading = false;

  Future<void> updateProfile({
    required String id,
    required String name,
    required String qualification,
    required String workAt,
    required String school,
    required String location,
  }) async {
    isLoading = true;
    notifyListeners();
    try {

      final body = {
        'id': id,
        'firstname': name,
        'lastname': 'g',
        'workAt': workAt,
        'location': location,
        'qualification': qualification,
        'school': school,
      };

      final res = await ApiService.post(
          requestBody: postEncode(body),
          headers: headers,
          endPoint: Endpoint.updateProfile
      );

      log("message: ${res.body}");
      if(res.statusCode == 200 || res.statusCode == 201){

        final jsonResponse = jsonDecode(res.body);
        final error = jsonResponse['error'];
        final message = jsonResponse['message'];
        log("message: ${res.body}");

        if(error){
          Get.snackbar("error", message);
        }else{
          Get.snackbar("success", message);
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

}
