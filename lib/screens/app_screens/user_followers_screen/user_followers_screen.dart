import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/screens/app_screens/search_screen/comp/searching_tile.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../../../constants/images_path.dart';
import '../../../providers/profile/profile_provider.dart';
import '../other_user_profile_screen/other_user_profile_screen.dart';

class UserFollowersScreen extends StatelessWidget {
  UserFollowersScreen({super.key,required this.userId});

  int userId;

  @override
  Widget build(BuildContext context) {

    final updateP = Provider.of<ProfileProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("Followers",
          [
            SizedBox(
                width: 7.w,
                child: Image.asset(ImagesPath.menuIcon)),
            SizedBox(width: 15,),
          ],
          isCenterTitle: true,
          isIconShow: true),
      body: FutureBuilder(
        future: updateP.followers(userId,context),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<ProfileProvider>(
          builder: (ctx, userProvider, child) => ListView.builder(
            itemCount: updateP.followersList.length,
            itemBuilder: (context, index) {
              if(updateP.followersList.isEmpty){
                Center(
                  child: TextWidget1(
                      text: "No Followers", fontSize: 24.dp,
                      fontWeight: FontWeight.w700, isTextCenter: false,
                      textColor: textColor),
                );
              }
              return InkWell(
                onTap: () {
                  Get.to(()=>OtherUserProfileScreen());
                },
                child: SearchingTile(
                    name: '${userProvider.followersList[index].firstname} ${userProvider.followersList[index].lastname}',
                    userName: userProvider.followersList[index].username.toString(),
                    imageUrl: userProvider.followersList[index].profile.toString(),
                    buttonText: "Follow Back", buttonAction: (){
                      log("tap");
                }
                ),
              );
            },),
        ),
      ),
    );
  }
}
