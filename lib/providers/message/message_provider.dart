import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api_services/api_services.dart';
import '../../api/endpoint/endpoint.dart';
import '../../constant.dart';

class MessageProvider extends ChangeNotifier{

  bool isLoading = false;

  Random random = Random();

  Future<void> sendPrivateMsg({
    required String msg,
    required String from,
    required String to,
    required String msgSize,
    required String userApiKey,
  }) async {
    isLoading = true;
    notifyListeners();
    try {

      int msgId = random.nextInt(1000000000);
      var date = DateTime.timestamp();

      final body = {
        'from': from,
        'to': to,
        'messageId': msgId.toString(),
        'messageSize': msgSize,
        'creationDate': date.toString(),
        'deliver_time': date.toString(),
        'packet': {
          "messageId": msgId.toString(),
          "conversationId": "196_2146",
          "type": "chat",
          "to": to,
          "sender": from,
          "receiver": "2177",
          "from":"BaibéDje",
          "nikname":"Baibé Dje Tissala  ",
          "message":msg,
          "verb":"post",
          "object":"text",
          "profile":"https://tiinver.com/api/uploads/profiles/default.png",
          "status":"0",
          "stamp": date.toString(),
          "resource":"Infinix X669",
          "isQuoted":"false"
        },
      };

      final res = await ApiService.post(
          requestBody: postEncode(body),
          headers: header2(userApiKey),
          endPoint: Endpoint.privateMessage
      );

      debugPrint("message: ${res.body}");
      if(res.statusCode == 200 || res.statusCode == 201){

        final jsonResponse = jsonDecode(res.body);
        final error = jsonResponse['error'];
        final message = jsonResponse['message'];
        debugPrint("message: ${res.body}");

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