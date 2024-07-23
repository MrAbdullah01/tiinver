import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/screens/app_screens/other_user_profile_screen/comp/following_status.dart';
import 'package:tiinver_project/screens/app_screens/other_user_profile_screen/comp/profile_container.dart';
import 'package:tiinver_project/screens/app_screens/report_screen/report_screen.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../../../constants/text_widget.dart';
import 'comp/dialogue_box.dart';

class OtherUserProfileScreen extends StatelessWidget {

  const OtherUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("Profile",
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>ReportScreen()));
                },
                value: 'Item 1',
                child: TextWidget1(text: "Report", fontSize: 16.dp,
                    fontWeight: FontWeight.w700, isTextCenter: false, textColor: themeColor),),
                PopupMenuItem(
                  onTap: (){
                    showDialog(
                        context: context, 
                        builder: (context) {
                          return DialogueBox().customDialogue(
                              context,
                              title: "Block Reminder ?",
                              subTitle: "If you block the user you are not gona "
                                  "see his activity on tinver",
                              primaryButtonText: "Block",
                              primaryTap: (){}
                          );
                        },);
                  },
                  value: 'Item 2',
                  child: TextWidget1(text: "Block", fontSize: 16.dp,
                      fontWeight: FontWeight.w700, isTextCenter: false, textColor: themeColor),),
            ],),
            SizedBox(width: 10,),
          ],
          isIconShow: true, isCenterTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    ProfileContainer(),
                    SizedBox(height: 8.h,)
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: lightGreyColor,
                        blurRadius: 2
                      )
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FollowingStatus(followNumber: "0",followText: "Following",buttonText: "Follow",icon: Icons.person,),
                      SizedBox(width: 10.w,),
                      FollowingStatus(followNumber: "0",followText: "Followers",buttonText: "Message",),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 45.w,
                        child: Image.asset(ImagesPath.dashBoardImage,fit: BoxFit.cover,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 2.5.h,
                                backgroundImage: AssetImage(ImagesPath.profileImage),
                              ),
                              SizedBox(width: 10,),
                              TextWidget1(text: "Reminder", fontSize: 10.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: bgColor),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget1(text: "Infinity Image", fontSize: 10.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: bgColor),
                              SizedBox(height: 6,),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 4.w,
                                      child: Image.asset(ImagesPath.likeIcon)),
                                  SizedBox(width: 5,),
                                  TextWidget1(text: "10k", fontSize: 10.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: bgColor),
                                  SizedBox(width: 5,),
                                  SizedBox(
                                      width: 4.w,
                                      child: Image.asset(ImagesPath.chatIcon)),
                                  SizedBox(width: 10,),
                                  TextWidget1(text: "1278", fontSize: 10.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: bgColor),

                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 25.h,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
            ),
            )
          ],
        ),
      ),
    );
  }
}
