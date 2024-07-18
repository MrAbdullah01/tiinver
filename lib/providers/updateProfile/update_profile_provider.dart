import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_services/api_services.dart';
import '../../api/endpoint/endpoint.dart';
import '../../constant.dart';
import '../../models/connectedUsers/connected_users_model.dart';
import '../../models/followersModel/followers_model.dart';
import '../../models/followingModel/following_model.dart';
import '../../models/login/user_login_model.dart';
import '../../models/register/user_sign_up_model.dart';

class UpdateProfileProvider with ChangeNotifier {

  bool isLoading = false;

  UserSignUpModel? _user;

  UserSignUpModel? get user => _user;

  List<Users> _followersList = [];

  List<Users> get followersList => _followersList;

  List<FollowingUsers> _followingsList = [];

  List<FollowingUsers> get followingsList => _followingsList;

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
          headers: header2,
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

  followers()async{
    try{

      isLoading = true;

      var res = await ApiService.get(Endpoint.followers(197, 197),header2);

        if (res.statusCode == 200) {
          Map<String, dynamic> jsonResponse = json.decode(res.body);
          if (jsonResponse['error'] == false) {
            List<dynamic> data = jsonResponse['users'];
            _followersList = data.map((item) => Users.fromJson(item)).toList();
            notifyListeners();
          } else {
            throw Exception('Failed to load users');
          }

          log(followersList.toString());
        }
    }catch(e){
      print(e);
    }
    finally{
    }
  }

  following()async{
    try{

      isLoading = true;

      var res = await ApiService.get(Endpoint.following(197, 197),header2);

        if (res.statusCode == 200) {
          Map<String, dynamic> jsonResponse = json.decode(res.body);
          if (jsonResponse['error'] == false) {
            List<dynamic> data = jsonResponse['users'];
            _followingsList = data.map((item) => FollowingUsers.fromJson(item)).toList();
            notifyListeners();
          } else {
            throw Exception('Failed to load users');
          }

          log(followingsList.toString());
        }
    }catch(e){
      print(e);
    }
    finally{
    }
  }

}
