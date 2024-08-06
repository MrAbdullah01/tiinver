import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/providers/otherUserProfile/other_user_profile_provider.dart';
import 'package:tiinver_project/providers/profile/profile_provider.dart';
import 'package:tiinver_project/screens/app_screens/other_user_profile_screen/comp/following_status.dart';
import 'package:tiinver_project/screens/app_screens/other_user_profile_screen/comp/profile_container.dart';
import 'package:tiinver_project/screens/app_screens/report_screen/report_screen.dart';
import 'package:tiinver_project/screens/app_screens/user_following_screen/user_following_screen.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../../../constants/text_widget.dart';
import '../../../firebase/chat/firebase_account_handling.dart';
import '../../../providers/signIn/sign_in_provider.dart';
import '../user_followers_screen/user_followers_screen.dart';
import 'comp/dialogue_box.dart';

class OtherUserProfileScreen extends StatelessWidget {

  OtherUserProfileScreen({super.key,required this.userId});

  int userId;

  @override
  Widget build(BuildContext context) {
    Provider.of<OtherUserProfileProvider>(context,listen: false).getOtherUserProfile(context,userId);
    var profileP = Provider.of<ProfileProvider>(context,listen: false);
    var signInP = Provider.of<SignInProvider>(context, listen: false);
    var otherUserProfileP = Provider.of<OtherUserProfileProvider>(context,listen: false);
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
                  Get.to(()=> ReportScreen(
                    userId: otherUserProfileP.userModel!.id!.toString(),
                    userName: otherUserProfileP.userModel!.username!.toString(),
                  ));
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
                              primaryTap: (){
                                Get.back();
                                otherUserProfileP.blockUser(
                                    userId: signInP.userId ?? "",
                                    userName: profileP.userModel.username ?? "",
                                    userApiKey: signInP.userApiKey ?? "",
                                    blockUserName: otherUserProfileP.userModel!.username!.toString(),
                                    blockUserId: otherUserProfileP.userModel!.id!.toString());
                              }
                          );
                        },
                    );
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
            Consumer<OtherUserProfileProvider>(builder: (context, value, child) {
              return value.isLoading ? CircularProgressIndicator()
                  : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      ProfileContainer(
                        name: value.userModel!.firstname!,
                        userName: value.userModel!.username!,
                        image: value.userModel!.profile!,
                      ),
                      SizedBox(height: 8.h,)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow:  [
                           BoxShadow(
                              color: lightGreyColor,
                              blurRadius: 2
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.off(()=>UserFollowingScreen(userId: value.userModel!.id!,));
                          },
                          child: FollowingStatus(
                            followNumber: value.userModel!.following!.toString(),
                            followText: "Following",
                            buttonText: value.userModel!.isFollowed == false ? "Follow" : "Following",
                            icon: Icon(Icons.person,size: 14.dp,color: bgColor,),
                            onTap: () {
                              profileP.follow(
                                  followId: signInP.userId.toString(),
                                  userId: value.userModel!.id.toString(),
                                  userApiKey: signInP.userApiKey.toString(),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        InkWell(
                          onTap: () {
                            Get.off(()=>UserFollowersScreen(userId: value.userModel!.id!,));
                          },
                          child: FollowingStatus(
                            followNumber: value.userModel!.followers!.toString(),
                            followText: "Followers",
                            buttonText: "Message",
                            onTap: () {
                              FirebaseAccountHandling.addChatUserToMyContact(context, value.userModel!.id!.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },),
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
            ),
          ],
        ),
      ),
    );
  }
}
