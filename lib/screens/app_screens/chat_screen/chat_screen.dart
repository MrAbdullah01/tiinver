import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/screens/app_screens/other_user_profile_screen/other_user_profile_screen.dart';

import '../../../constants/colors.dart';
import '../../../constants/images_path.dart';
import '../../../constants/text_widget.dart';
import '../../../widgets/field_widget.dart';
import '../../../widgets/header.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  var msgC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("",
        [
        SizedBox(
          width: 82.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherUserProfileScreen(userId: 2177,)));
                },
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: themeColor,
                              width: 1.5
                          )
                      ),
                      child: CircleAvatar(
                        radius: 3.7.h,
                        backgroundColor: lightGreyColor,
                        backgroundImage: AssetImage(ImagesPath.profileImage),
                      ),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      width:35.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget1(text: "name", fontSize: 20.dp, fontWeight: FontWeight.w600, isTextCenter: false, textColor: themeColor),
                          TextWidget1(text: "userName", fontSize: 10.dp, fontWeight: FontWeight.w400, isTextCenter: false, textColor: textColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                  height: 8.h,
                  child: Image.asset(ImagesPath.editIcon)),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                  height: 8.h,
                  child: Image.asset(ImagesPath.phoneIcon)),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                  height: 8.h,
                  child: Image.asset(ImagesPath.menuIcon)),
            ],
          ),
        )
      ],
        toolbarHeight: 10.h,
        isIconShow: true,isCenterTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(),
        ],
      ),
      floatingActionButton: Container(
        color: tileColor,
        padding: EdgeInsets.only(bottom: 0),
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 65.w,
                child: InputField(
                  inputController: msgC,
                  hintText: "messag...",
                  bdRadius: 0,
                )),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    height: 8.h,
                    child: Image.asset(msgC.text.isEmpty ? ImagesPath.editIcon : ImagesPath.voiceIcon)),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    height: 8.h,
                    child: Image.asset(ImagesPath.galleryIcon)),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    height: 8.h,
                    child: Image.asset(ImagesPath.sendIcon)),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
