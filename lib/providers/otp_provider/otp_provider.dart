import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/api/api_services/api_services.dart';
import 'package:tiinver_project/api/endpoint/endpoint.dart';

import '../../api_services/otp_services/otp_services.dart';
import '../../models/otp_model/otp_model.dart';
import '../sign_up_provider/sign_up_provider.dart';

class OtpProvider extends ChangeNotifier{

  late Timer _timer;
  int _start = 60;

  int get start => _start;

  OtpModel? _otpModel;

  int? code;

  OtpModel? get otpModel => _otpModel;

  bool isLoading = false;

  OtpModel? _user;

  final OtpServices _apiService = OtpServices();

  OtpModel? get user => _user;

  Future<void> otp(email) async {
    Random random = Random();
    code = random.nextInt(9000) + 1000; // Ensures the code is 4 digits
    code.toString();
    isLoading = true;
    notifyListeners();
    try {
      var body = {
        'to': "toMsg",
        'subject': "OTP",
        'message': "message",
      };

      String encodedBody = body.entries.map((entry) =>
      '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}').join('&');

      final response = await ApiService.post(
          requestBody: encodedBody,
          headers: headers,
          endPoint: Endpoint.mail
      );

      // final response = await _apiService.otp(email, code.toString())
      //     .whenComplete((){
      //   startTimer();
      // });
      _user = OtpModel.fromJson(response);
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  otpVerification(int otp,context)async {
    if(code == otp){
      isLoading = true;
      notifyListeners();
      await Provider.of<SignUpProvider>(context, listen: false).signUp().whenComplete(()async{
        Provider.of<SignUpProvider>(context, listen: false).storeUserApiKey();
        isLoading = false;
        notifyListeners();
      }).onError((error, stackTrace) {
        Get.snackbar("Error", "$error");
        isLoading = false;
      },);
    }else{
      Get.snackbar("Error", "Invalid Pin");
    }

  }

  void startTimer() {
    _start = 60;
    notifyListeners();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        timer.cancel();
        performFunction();
      } else {
        _start--;
        notifyListeners();
      }
    });
  }

  void performFunction() {
    code = 0;
    notifyListeners();
    // Your function logic here
    print("One minute is up!");
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }


}