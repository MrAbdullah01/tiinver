import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/providers/signIn/sign_in_provider.dart';
import 'package:tiinver_project/screens/app_screens/settingScreen/setting_screen.dart';
import 'package:tiinver_project/screens/app_screens/user_followers_screen/user_followers_screen.dart';
import 'package:tiinver_project/screens/app_screens/user_following_screen/user_following_screen.dart';
import 'package:tiinver_project/widgets/header.dart';
import '../../../constants/images_path.dart';
import '../../../providers/profile/profile_provider.dart';
import 'media_screen/media_screen.dart';
import 'my_profile_screen/my_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context, listen: false);
    final profileP = Provider.of<ProfileProvider>(context, listen: false);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("",
          [
            PopupMenuButton(
              surfaceTintColor: bgColor,
              color: bgColor,
              child: SizedBox(
                  width: 7.w,
                  child: Image.asset(ImagesPath.menuIcon)),
              itemBuilder: (context) =>[
                PopupMenuItem(
                  onTap: (){
                    Get.to(()=>SettingScreen());
                  },
                  value: 'Item 1',
                  child: TextWidget1(
                      text: "Settings", fontSize: 16.dp,
                      fontWeight: FontWeight.w700,
                      isTextCenter: false,
                      textColor: themeColor),),
              ],),
            SizedBox(width: 15,),
          ],
          isIconShow: false),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bgColor,
                        border: Border.all(
                            color: themeColor,
                            width: 2.dp
                        )
                    ),
                    child: CircleAvatar(
                      radius: 8.h,
                      backgroundColor: lightGreyColor,
                      backgroundImage: profileP.userModel!.profile != null ?
                      NetworkImage(profileP.userModel!.profile.toString())
                          : AssetImage(ImagesPath.profileImage),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 5,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: themeColor,
                          shape: BoxShape.circle
                      ),
                      child: Image.asset(ImagesPath.checkIcon,color: bgColor,),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Consumer<ProfileProvider>(builder: (context, value, child) {
              return Center(
                child: TextWidget1(text: profileP.userModel!.firstname.toString(), fontSize: 24.dp, fontWeight: FontWeight.w700,
                  isTextCenter: true, textColor: themeColor,maxLines: 2,),
              );
            },),
            Consumer<ProfileProvider>(builder: (context, value, child) {
              return Center(
                child: TextWidget1(
                    text: profileP.userModel!.username.toString(),
                    fontSize: 10.dp, fontWeight: FontWeight.w500,
                    isTextCenter: false, textColor: darkGreyColor),
              );
            },),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                    Get.to(()=>UserFollowingScreen(userId: int.parse(provider.userId!)));
                  },
                  child: Consumer<ProfileProvider>(builder: (context, value, child) {
                    return Column(
                      children: [
                        TextWidget1(
                            text: profileP.userModel!.following.toString(),
                            fontSize: 20.dp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: darkGreyColor),
                        TextWidget1(text: "Following", fontSize: 16.dp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: themeColor),
                      ],
                    );
                  },)
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                    Get.to(()=>UserFollowersScreen(userId: int.parse(provider.userId!),));
                  },
                  child: Consumer<ProfileProvider>(builder: (context, value, child) {
                    return Column(
                      children: [
                        TextWidget1(
                            text: profileP.userModel!.followers.toString(),
                            fontSize: 20.dp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: darkGreyColor),
                        TextWidget1(text: "Followers", fontSize: 16.dp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: themeColor),
                      ],
                    );
                  },),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              color: lightGreyColor,
              child: TabBar(
                indicatorColor: darkGreyColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                Tab(
                  icon: TextWidget1(text: "My Profile", fontSize: 14.dp, fontWeight: FontWeight.w500,
                      isTextCenter: false, textColor: textColor),),
                Tab(
                  icon: TextWidget1(text: "Media", fontSize: 14.dp, fontWeight: FontWeight.w500,
                      isTextCenter: false, textColor: textColor),),
              ]),
            ),
            SizedBox(
              height: 70.h,
                width: 100.w,
                child: TabBarView(
                    children: [
                      MyProfileScreen(),
                      MediaScreen()
            ]))
          ],
        ),
      ),
    )
    );
  }
}
 //model1: profileP.userModel!,model2: provider.user!,
//value.userModel!.userData.username.toString()