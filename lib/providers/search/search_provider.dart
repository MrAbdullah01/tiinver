import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api_services/api_services.dart';
import '../../api/endpoint/endpoint.dart';
import '../../constant.dart';
import '../../models/searchModel/search_model.dart';

class SearchProvider extends ChangeNotifier{

  List<SearchUsers> _users = [];

  List<SearchUsers> get users => _users;

  var searchC = TextEditingController();

  bool isLoading = false;

  clearSearch(){
    searchC.text = "";
    users.clear();
    notifyListeners();
  }

  Future<void> searchUsers({
    required String key,
    required String userApiKey,
    String? userId}) async {
    isLoading = true;
    notifyListeners();
    try {

      final body = {
        'key': searchC.text,
        'userId': userId,
      };

      final res = await ApiService.post(
          requestBody: postEncode(body),
          headers: header2(userApiKey),
          endPoint: Endpoint.search
      );

      log("message: ${res.body}");
      if (res.statusCode == 200 || res.statusCode == 201) {
        var jsonResponse = json.decode(res.body);
        var searchModel = SearchModel.fromJson(jsonResponse);
        _users = searchModel.users ?? [];
      } else {
        throw Exception('Failed to load search results');
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