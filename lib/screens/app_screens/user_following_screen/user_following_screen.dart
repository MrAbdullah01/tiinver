import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/images_path.dart';
import '../../../providers/profile/profile_provider.dart';
import '../../../providers/signIn/sign_in_provider.dart';
import '../../../widgets/header.dart';
import '../other_user_profile_screen/other_user_profile_screen.dart';
import '../search_screen/comp/searching_tile.dart';

class UserFollowingScreen extends StatelessWidget {
  UserFollowingScreen({super.key,required this.userId});

  int userId;

  @override
  Widget build(BuildContext context) {
    var updateP = Provider.of<ProfileProvider>(context, listen: false);
    var signInP = Provider.of<SignInProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("Following",
          [
            SizedBox(
                width: 7.w,
                child: Image.asset(ImagesPath.menuIcon)),
            SizedBox(width: 15,),
          ],
          isCenterTitle: true,
          isIconShow: true),
      body: FutureBuilder(
        future: Provider.of<ProfileProvider>(context, listen: false).following(userId,context),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<ProfileProvider>(
          builder: (ctx, userProvider, child) => ListView.builder(
            itemCount: updateP.followingsList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.off(()=>OtherUserProfileScreen(userId: userProvider.followingsList[index].id!,));
                },
                child: SearchingTile(
                    name: '${userProvider.followingsList[index].firstname} ${userProvider.followingsList[index].lastname}',
                    userName: userProvider.followingsList[index].username.toString(),
                    imageUrl: userProvider.followingsList[index].profile.toString(),
                    buttonText: userProvider.followingsList[index].isFollowed == false ? "Follow Back" : "Friends",
                    buttonAction: (){
                      userProvider.follow(
                          followId: signInP.userId.toString(),
                          userId: userProvider.followingsList[index].id.toString(),
                          userApiKey: signInP.userApiKey.toString()
                      );
                    }
                ),
              );
            },),
        ),
      ),
    );
  }
}
