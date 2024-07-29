import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/models/suggestionsModel/suggestions_model.dart';
import 'package:tiinver_project/providers/dashboard/dashboard_provider.dart';
import 'package:tiinver_project/providers/profile/profile_provider.dart';
import 'package:tiinver_project/providers/suggestions/suggestions_provider.dart';
import 'package:tiinver_project/screens/app_screens/other_user_profile_screen/comp/dialogue_box.dart';

import 'package:tiinver_project/widgets/header.dart';
import 'package:tiinver_project/widgets/submit_button.dart';

import '../../../models/feedTimeLineModel/feed_time_line_model.dart';
import '../../../providers/search/search_provider.dart';
import '../../../providers/signIn/sign_in_provider.dart';
import '../../../widgets/image_loader_widget.dart';
import '../detailScreen/detail_screen.dart';
import '../other_user_profile_screen/other_user_profile_screen.dart';
import '../search_screen/search_screen.dart';
import 'comp/media_widget.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  var searchC = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var signInP = Provider.of<SignInProvider>(context, listen: false);

    // Provider.of<ProfileProvider>(context,listen: false).getUserProfile(context);

    Provider.of<DashboardProvider>(context, listen: false).fetchTimeline(
      int.parse(signInP.userId.toString()),
      100,
      0,
      signInP.userApiKey.toString(),
    );

    log(signInP.userApiKey.toString());

    Provider.of<SuggestionsProvider>(context, listen: false).fetchSuggestions(
      int.parse(signInP.userId.toString()),
      signInP.userApiKey.toString(),
    );



  }

  @override
  Widget build(BuildContext context) {

    var signInP = Provider.of<SignInProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header2("Tiinver", [
            GestureDetector(
              onTap: (){
                Provider.of<SearchProvider>(context,listen: false).clearSearch();
                Get.to(()=>SearchScreen());
              },
              child: SizedBox(
                  width: 7.w,
                  child: Image.asset(ImagesPath.searchingIcon)),
            ),
            SizedBox(width: 10,),
        PopupMenuButton(
          surfaceTintColor: bgColor,
          color: bgColor,
          child: SizedBox(
              width: 7.w,
              child: Image.asset(ImagesPath.menuIcon)),
          itemBuilder: (context) =>[
            PopupMenuItem(
              onTap: (){
                showDialog(context: context, builder: (context) {
                  return DialogueBox().customDialogue(
                      context,
                      title: 'Logout',
                      subTitle: "Are you sure you want to logout?",
                      primaryButtonText: "logout",
                      primaryTap: (){
                        Provider.of<SignInProvider>(context,listen: false).logout();
                      });
                },);
              },
              value: 'Item 1',
              child: TextWidget1(text: "Logout", fontSize: 16.dp,
                  fontWeight: FontWeight.w700, isTextCenter: false, textColor: themeColor),),
            PopupMenuItem(
              onTap: (){
                // showDialog(
                //   context: context,
                //   builder: (context) {
                //     return DialogueBox().customDialogue(
                //         context,
                //         title: "Block Reminder ?",
                //         subTitle: "If you block the user you are not gona "
                //             "see his activity on tinver",
                //         primaryButtonText: "Block",
                //         primaryTap: (){}
                //     );
                //   },);
              },
              value: 'Item 2',
              child: TextWidget1(text: "Parameter", fontSize: 16.dp,
                  fontWeight: FontWeight.w700, isTextCenter: false, textColor: themeColor),),
          ],),
        SizedBox(width: 15,),
          ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20.h,
            width: 100.w,
            child: Consumer<SuggestionsProvider>(builder: (context, value, child) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                itemCount: value.suggestions.length,
                itemBuilder: (context, index) {
                  var user = value.suggestions[index];
                  return InkWell(
                    onTap: () {
                      Get.to(()=>OtherUserProfileScreen(userId: user.id,));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 10.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: ImageLoaderWidget(imageUrl: user.profile.toString()),
                              ),
                            ),
                            Spacer(),
                            TextWidget1(
                                text: '${user.firstname.toString()} ${user.lastname.toString()}',
                                fontSize: 14.dp, fontWeight: FontWeight.w600,overFlow: TextOverflow.ellipsis,
                                isTextCenter: false, textColor: textColor),
                            TextWidget1(
                                text: '@${user.username.toString()}', overFlow: TextOverflow.ellipsis,
                                fontSize: 8.dp, fontWeight: FontWeight.w500,
                                isTextCenter: false, textColor: darkGreyColor),
                            Spacer(),
                            SubmitButton(
                              width: 20.w,
                              height: 25,
                              title: "Follow",
                              textSize: 8.dp,
                              press: () {
                                Provider.of<ProfileProvider>(context,listen: false).
                                follow(
                                    followId: signInP.userId!.toString(),
                                    userId: user.id.toString(),
                                    userApiKey: signInP.userApiKey!.toString());
                              },),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },),
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: 100.w,
            child: Consumer<DashboardProvider>(builder: (context, value, child) {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: value.timeLine.length,
                itemBuilder: (BuildContext context, int index) {
                  var activity = value.timeLine[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailScreen(
                        activity: activity,
                      ));
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 27.h,
                            width: 45.w,
                            child: MediaWidget(activity: activity),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: ImageLoaderWidget(imageUrl: activity.profile!),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  SizedBox(
                                    width: 100,
                                    child: TextWidget1(text: '${activity.firstname} ${activity.lastname}',
                                        fontSize: 10.dp, fontWeight: FontWeight.w700,
                                        maxLines: 1, overFlow: TextOverflow.ellipsis,
                                        isTextCenter: false, textColor: bgColor),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget1(text: "${activity.message}", fontSize: 10.dp,
                                    fontWeight: FontWeight.w700, isTextCenter: false,maxLines: 1,
                                    textColor: bgColor, overFlow: TextOverflow.ellipsis,),
                                  SizedBox(height: 6,),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 4.w,
                                          child: Image.asset(ImagesPath.likeIcon,color: activity.isLiked! ? Colors.red : bgColor,)),
                                      SizedBox(width: 5,),
                                      TextWidget1(text: "${activity.likes ?? ''}", fontSize: 10.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: bgColor),
                                      SizedBox(width: 5,),
                                      SizedBox(
                                          width: 4.w,
                                          child: Image.asset(ImagesPath.chatIcon)),
                                      SizedBox(width: 10,),
                                      TextWidget1(text: activity.comment.toString() ?? '', fontSize: 10.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: bgColor),

                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 27.h,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
              ),
              );
            },),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
        ),
        child: Icon(Icons.add_rounded,color: bgColor,size: 30.dp,),
          backgroundColor: themeColor,
          onPressed: (){}
      ),
    );
  }
}



//StreamBuilder<List<Activity>>(
//                 stream: value.timelineStream,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//
//                   if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   }
//
//                   if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(child: Text('No activities found.'));
//                   }
//
//                   List<Activity> activities = snapshot.data!;
//
//                   return GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     itemCount: activities.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final activity = activities[index];
//                       return GestureDetector(
//                         onTap: () {
//                           Get.to(() => DetailScreen(
//                               activity: activity,
//                           ));
//                         },
//                         child: Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child: Container(
//                                 height: 27.h,
//                                 width: 45.w,
//                                 child: MediaWidget(activity: activity),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(100),
//                                         child: SizedBox(
//                                           height: 40,
//                                           width: 40,
//                                           child: ImageLoaderWidget(imageUrl: activity.profile!),
//                                         ),
//                                       ),
//                                       SizedBox(width: 10,),
//                                       SizedBox(
//                                         width: 100,
//                                         child: TextWidget1(text: '${activity.firstname} ${activity.lastname}',
//                                             fontSize: 10.dp, fontWeight: FontWeight.w700,
//                                             maxLines: 1, overFlow: TextOverflow.ellipsis,
//                                             isTextCenter: false, textColor: bgColor),
//                                       ),
//                                     ],
//                                   ),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       TextWidget1(text: "${activity.message}", fontSize: 10.dp,
//                                           fontWeight: FontWeight.w700, isTextCenter: false,maxLines: 1,
//                                           textColor: bgColor, overFlow: TextOverflow.ellipsis,),
//                                       SizedBox(height: 6,),
//                                       Row(
//                                         children: [
//                                           SizedBox(
//                                               width: 4.w,
//                                               child: Image.asset(ImagesPath.likeIcon,color: activity.isLiked! ? Colors.red : bgColor,)),
//                                           SizedBox(width: 5,),
//                                           TextWidget1(text: "${activity.likes ?? ''}", fontSize: 10.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: bgColor),
//                                           SizedBox(width: 5,),
//                                           SizedBox(
//                                               width: 4.w,
//                                               child: Image.asset(ImagesPath.chatIcon)),
//                                           SizedBox(width: 10,),
//                                           TextWidget1(text: activity.comment.toString() ?? '', fontSize: 10.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: bgColor),
//
//                                         ],
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisExtent: 27.h,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10
//                   ),
//                   );
//                 },
//               )




//ListView.builder(
//               itemCount: activities.length,
//               itemBuilder: (context, index) {
//                 final activity = activities[index];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(activity.profile ?? ''),
//                   ),
//                   title: Text('${activity.firstname} ${activity.lastname}'),
//                   subtitle: Text(activity.message ?? ''),
//                   trailing: Text(activity.stamp ?? ''),
//                 );
//               },
//             )