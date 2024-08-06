import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/models/getUserModel/get_user_model.dart';
import 'package:tiinver_project/providers/signIn/sign_in_provider.dart';
import '../../api/api_services/api_services.dart';
import '../../api/endpoint/endpoint.dart';
import '../../constant.dart';
import '../../gloabal_key.dart';
import '../../models/followersModel/followers_model.dart';
import '../../models/followingModel/following_model.dart';
import '../../models/register/user_sign_up_model.dart';

class ProfileProvider with ChangeNotifier {

  final signProvider = GlobalProviderAccess.signProvider;

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var workController = TextEditingController();
  var qualificationController = TextEditingController();
  var schoolController = TextEditingController();

  bool _isLoading = false;

  bool get  isLoading => _isLoading;

  UserSignUpModel? _user;

  UserSignUpModel? get user => _user;

  List<Users> _followersList = [];

  List<Users> get followersList => _followersList;

  List<FollowingUsers> _followingsList = [];

  List<FollowingUsers> get followingsList => _followingsList;

  GetUserModel _userModel = GetUserModel();

  GetUserModel get userModel => _userModel;

  Users followerUser = Users();

  // Future<void> loadUserProfileFromPreferences() async {
  //   var sp = await SharedPreferences.getInstance();
  //   String? userJson = sp.getString('userProfileData');
  //   if (userJson != null) {
  //     userModel = GetUserModel.fromJson(json.decode(userJson));
  //   }
  //   notifyListeners();
  // }

  // Future<void> loadUserFromPreferences() async {
  //   var sp = await SharedPreferences.getInstance();
  //   String? userJson = sp.getString('getUserModel');
  //   if (userJson != null) {
  //     _userModel = GetUserModel.fromJson(json.decode(userJson));
  //   }
  //   notifyListeners();
  // }

  clearList(){
    _followingsList.clear();
    _followersList.clear();
    notifyListeners();
  }

  getUserProfile(context) async {
    try{

      // isLoading = true;

      var res = await ApiService.get(
          Endpoint.getUser(
              int.parse(Provider.of<SignInProvider>(context,listen: false).userId!),
              int.parse(Provider.of<SignInProvider>(context,listen: false).userId!)
          ),
          header2(Provider.of<SignInProvider>(context,listen: false).userApiKey));

      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<String, dynamic> jsonResponse = json.decode(res.body);
        if (jsonResponse['error'] == false) {

          _userModel = GetUserModel.fromJson(jsonResponse['userData']);

          // Assign values to variables
          nameController.text = _userModel.firstname!;
          qualificationController.text = _userModel.qualification!;
          workController.text = _userModel.work!;
          schoolController.text = _userModel.school!;
          locationController.text = _userModel.location!;
          notifyListeners();

          //log("*******${name}******");

        } else {
          throw Exception('Failed to load users');
        }
        //log(followingsList.toString());
      }
    }catch(e){
      print(e);
    }
    // finally{
    // }
  }

  Future<void> updateProfile({
    required String id,
    required String name,
    required String qualification,
    required String workAt,
    required String school,
    required String location,
    required String userApiKey,
  }) async {
    _isLoading = true;
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
          headers: header2(userApiKey),
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
      _isLoading = false;
      notifyListeners();
    }
  }

  followers(int userId,context)async{
    try{

      _isLoading = true;

      var res = await ApiService.get(Endpoint.followers(userId, userId),header2(Provider.of<SignInProvider>(context,listen: false).userApiKey));

        if (res.statusCode == 200 || res.statusCode == 201) {
          Map<String, dynamic> jsonResponse = json.decode(res.body);
          if (jsonResponse['error'] == false) {
            List<dynamic> data = jsonResponse['users'];
            _followersList = data.map((item) => Users.fromJson(item)).toList();
            notifyListeners();
          } else {
            throw Exception('Failed to load users');
          }

          log("{followersList.toString()}");
        }
    }catch(e){
      print(e);
    }
    finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  following(int userId,context)async{
    try{

      _isLoading = true;

      var res = await ApiService.get(
          Endpoint.following(
              userId, userId),
          header2(Provider.of<SignInProvider>(context,listen: false).userApiKey));

        if (res.statusCode == 200 || res.statusCode == 201) {
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
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> follow({
    required String followId,
    required String userId,
    required String userApiKey,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {

      final body = {
        'followId': followId,
        'userId': userId,
      };

      final res = await ApiService.post(
          requestBody: postEncode(body),
          headers: header2(userApiKey),
          endPoint: Endpoint.follow
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
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAccount({
    required String userId,
    required String userApiKey,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {

      final body = {
        'userId': userId,
      };

      final res = await ApiService.post(
          requestBody: postEncode(body),
          headers: header2(signProvider!.userApiKey),
          endPoint: Endpoint.deleteAccount
      );

      log("message: ${res.body}");
      if(res.statusCode == 200 || res.statusCode == 201){

        final jsonResponse = jsonDecode(res.body);
        final error = jsonResponse['error'];
        final msg = jsonResponse['user'];
        log("message: ${res.body}");

        if(error){
          Get.snackbar("Error", "Something went wrong!");
        }else{
          Get.snackbar("Successful", msg);
          signProvider!.logout();
        }
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

}
