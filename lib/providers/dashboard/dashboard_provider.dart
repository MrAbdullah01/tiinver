import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/api/endpoint/endpoint.dart';
import '../../api/api_services/api_services.dart';
import '../../models/feedTimeLineModel/feed_time_line_model.dart';
import '../signIn/sign_in_provider.dart';

class DashboardProvider extends ChangeNotifier{

  List<Comment> _comments = [];
  bool _loading = false;
  String? _error;

  List<Comment> get comments => _comments;
  bool get loading => _loading;
  String? get error => _error;

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
    _loading = true;
    notifyListeners();

    try {
      final response = await ApiService.get(
          Endpoint.getComment(activityId),
          header2(userApiKey)
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (!jsonResponse['error']) {
          _comments = (jsonResponse['comments'] as List)
              .map((comment) => Comment.fromJson(comment))
              .toList();
          _error = null;
        } else {
          _error = 'Failed to load comments';
        }
      } else {
        _error = 'Failed to load comments';
      }
    } catch (e) {
      _error = e.toString();
      _comments = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timelineController.close();
    super.dispose();
  }
}
