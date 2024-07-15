import 'package:flutter/material.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/widgets/header.dart';

import 'comp/follow_notification_tile.dart';
import 'comp/simple_notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("Notification",
          [],
          isCenterTitle: true,
          isIconShow: false),
      body: ListView(
        children: [
          FollowNotificationTile(),
          SimpleNotificationTile(),
          FollowNotificationTile(bgColor: lightGreyColor.withOpacity(0.3),),
          SimpleNotificationTile(bgColor: lightGreyColor.withOpacity(0.3),),
        ],
      ),
    );
  }
}
