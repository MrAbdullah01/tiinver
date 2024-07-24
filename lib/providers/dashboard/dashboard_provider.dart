import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/api/endpoint/endpoint.dart';
import '../../api/api_services/api_services.dart';
import '../../constant.dart';
import '../../models/feedTimeLineModel/feed_time_line_model.dart';
import '../signIn/sign_in_provider.dart';

class DashboardProvider extends ChangeNotifier{

  bool isLoading = false;

  // List<Comment> _comments = [];
  // bool _loading = false;
  // String? _error;
  //
  // List<Comment> get comments => _comments;
  // bool get loading => _loading;
  // String? get error => _error;

  // bool isLoading = false;

  var commentC = TextEditingController();

  final StreamController<List<Comment>> _commentController = StreamController.broadcast();

  Stream<List<Comment>> get commentStream => _commentController.stream;

  final StreamController<List<Activity>> _timelineController = StreamController.broadcast();

  Stream<List<Activity>> get timelineStream => _timelineController.stream;

  Future<void> fetchTimeline(int id, int limit, int offset,userApiKey) async {
    try {
      final response = await ApiService.get(
        Endpoint.getFeedTimeLine(id, limit, offset),
        header2(userApiKey)
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (!jsonResponse['error']) {
          List<Activity> activities = (jsonResponse['activities'] as List)
              .map((activity) => Activity.fromJson(activity))
              .toList();
          _timelineController.add(activities);
        } else {
          _timelineController.addError('Failed to load timeline');
        }
      } else {
        _timelineController.addError('Failed to load timeline');
      }
    } catch (e) {
      _timelineController.addError(e.toString());
    }
  }

  Future<void> fetchComments(int activityId, String userApiKey) async {
    try {
      final response = await ApiService.get(
          Endpoint.getComment(activityId),
          header2(userApiKey)
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (!jsonResponse['error']) {
          List<Comment> comments = (jsonResponse['comments'] as List)
              .map((comment) => Comment.fromJson(comment))
              .toList();
          _commentController.add(comments);
        } else {
          _commentController.addError('Failed to load comments');
        }
      } else {
        _commentController.addError('Failed to load comments');
      }
    } catch (e) {
      _commentController.addError(e.toString());
    }
  }

  // Future<void> fetchComments(int activityId, String userApiKey) async {
  //   _loading = true;
  //   notifyListeners();
  //
  //   try {
  //     final response = await ApiService.get(
  //         Endpoint.getComment(activityId),
  //         header2(userApiKey)
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final jsonResponse = json.decode(response.body);
  //       if (!jsonResponse['error']) {
  //         _comments = (jsonResponse['comments'] as List)
  //             .map((comment) => Comment.fromJson(comment))
  //             .toList();
  //         _error = null;
  //       } else {
  //         _error = 'Failed to load comments';
  //       }
  //     } else {
  //       _error = 'Failed to load comments';
  //     }
  //   } catch (e) {
  //     _error = e.toString();
  //     _comments = [];
  //   } finally {
  //     _loading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> postComment({
    required String activityId,
    required String userId,
    required String userApiKey,
  }) async {
    log(activityId);
    log(userId);
    isLoading = true;
    notifyListeners();
    try {

      final body = {
        'activityId': activityId,
        'userId': userId,
        'comment': commentC.text.toString(),
      };

      final res = await ApiService.post(
          requestBody: postEncode(body),
          headers: header2(userApiKey),
          endPoint: Endpoint.comment
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
      commentC.text = "";
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timelineController.close();
    super.dispose();
  }
}
