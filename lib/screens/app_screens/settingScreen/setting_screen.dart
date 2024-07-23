import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/text_widget.dart';

import '../../../constants/images_path.dart';
import '../../../widgets/header.dart';
import 'comp/setting_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("",
          [
            SizedBox(
                width: 7.w,
                child: Image.asset(ImagesPath.menuIcon)),
            SizedBox(width: 15,),
          ],
          isIconShow: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextWidget1(text: "Settings",
                fontSize: 24.dp,
                fontWeight: FontWeight.w700,
                isTextCenter: false,
                textColor: themeColor),
          ),
          SizedBox(height: 50,),
          SettingTile(title: "Account",image: ImagesPath.personIcon,onTap: (){},),
          SettingTile(title: "Chats",image: ImagesPath.chatIcon,onTap: (){},),
          SettingTile(title: "Notification",image: ImagesPath.notificationIcon,onTap: (){},),
          SettingTile(title: "Privacy and Security",image: ImagesPath.privacyIcon,onTap: (){},),
          SettingTile(title: "Storage and Data",image: ImagesPath.storageIcon,onTap: (){},),
          SettingTile(title: "Help",image: ImagesPath.helpIcon,onTap: (){},),
          SettingTile(title: "About",image: ImagesPath.infoIcon,onTap: (){},),
        ],
      ),
    );
  }
}
