import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/screens/app_screens/user_followers_screen/user_followers_screen.dart';
import 'package:tiinver_project/screens/app_screens/user_following_screen/user_following_screen.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../../../constants/images_path.dart';
import 'media_screen/media_screen.dart';
import 'my_profile_screen/my_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("",
          [
            SizedBox(
                width: 7.w,
                child: Image.asset(ImagesPath.menuIcon)),
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
                      backgroundImage: AssetImage(ImagesPath.profileImage),
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
            Center(
              child: TextWidget1(text: "Lelsi Alexandra", fontSize: 24.dp, fontWeight: FontWeight.w700,
                  isTextCenter: false, textColor: themeColor),
            ),
            Center(
              child: TextWidget1(text: "Designer @inspiration", fontSize: 10.dp, fontWeight: FontWeight.w500,
                  isTextCenter: false, textColor: darkGreyColor),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserFollowingScreen(),));
                  },
                  child: Column(
                    children: [
                      TextWidget1(text: "0", fontSize: 20.dp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: darkGreyColor),
                      TextWidget1(text: "Following", fontSize: 16.dp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: themeColor),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserFollowersScreen(),));
                  },
                  child: Column(
                    children: [
                      TextWidget1(text: "0", fontSize: 20.dp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: darkGreyColor),
                      TextWidget1(text: "Followers", fontSize: 16.dp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: themeColor),
                    ],
                  ),
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
