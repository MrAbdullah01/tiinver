import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/screens/app_screens/accountPrivacyScreen/account_privacy_screen.dart';
import 'package:tiinver_project/screens/app_screens/accountScreen/account_screen.dart';
import 'package:tiinver_project/screens/app_screens/ringtoneScreen/ringtone_screen.dart';
import 'package:tiinver_project/screens/app_screens/themeScreen/theme_screen.dart';

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
          SettingTile(
            title: "Account",image: ImagesPath.personIcon,onTap: (){
            Get.to(()=> AccountScreen());
          },),
          SettingTile(title: "Chats",image: ImagesPath.chatIcon,onTap: (){
            Get.to(()=> ThemeScreen());
          },),
          SettingTile(title: "Notification",image: ImagesPath.notificationIcon,onTap: (){
            Get.to(()=> RingtoneScreen());
          },),
          SettingTile(title: "Privacy and Security",image: ImagesPath.privacyIcon,onTap: (){
            Get.to(()=> AccountPrivacyScreen());
          },),
          SettingTile(title: "Storage and Data",image: ImagesPath.storageIcon,onTap: (){},),
          SettingTile(title: "Help",image: ImagesPath.helpIcon,onTap: (){},),
          SettingTile(title: "About",image: ImagesPath.infoIcon,onTap: (){},),
        ],
      ),
    );
  }
}
