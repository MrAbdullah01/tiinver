import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/screens/app_screens/other_user_profile_screen/comp/dialogue_box.dart';

import 'package:tiinver_project/widgets/header.dart';

import '../../../providers/signIn/sign_in_provider.dart';
import '../search_screen/search_screen.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  var searchC = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header2("Tiinver", [
            GestureDetector(
              onTap: (){
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
      body: GridView.builder(
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
                        TextWidget1(text: "Dreaming", fontSize: 10.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: bgColor),
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
