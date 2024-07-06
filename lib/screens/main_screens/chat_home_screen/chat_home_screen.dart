import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/screens/main_screens/chat_screen/chat_screen.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../../../constants/images_path.dart';
import '../../../constants/text_widget.dart';
import '../tiinver_ai_chat/tiinver_ai_chat.dart';
import 'comp/chat_tile.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header().header1("Chats", [
        SizedBox(
            width: 7.w,
            child: Image.asset(ImagesPath.menuIcon)),
        SizedBox(width: 15,),
      ],isCenterTitle: true, isIconShow: false),
      backgroundColor: bgColor,
      body: Column(
        children: [
          ChatTile(
              name: "Tiinver Ai",
              chatText: "Artificial Intelligence Assistant",
              lastMsgTime: "01:45 PM",
              tapAction: (){
                Get.to(()=>TiinverAiChat());
              },
              image: ImagesPath.aiImage),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
              return ChatTile(
                  name: "Reminder",
                  chatText: "Hello",
                  lastMsgTime: "01:45 PM",
                  tapAction: (){
                    Get.to(()=>ChatScreen());
                  },
                  image: ImagesPath.profileImage);
            },),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: themeColor,
                  shape: BoxShape.circle
                ),
                child: Center(child: Icon(Icons.add_rounded,color: bgColor,)),
              ),
              SizedBox(width: 10,),
              TextWidget1(text: "New Messages", fontSize: 20.dp, fontWeight: FontWeight.w600, isTextCenter: false, textColor: themeColor),

            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle
                ),
                child: Center(child: Icon(Icons.person_add_rounded,color: themeColor,size: 8.w,)),
              ),
              SizedBox(width: 10,),
              TextWidget1(text: "Invite friends and family", fontSize: 20.dp, fontWeight: FontWeight.w600, isTextCenter: false, textColor: themeColor),

            ],
          )
        ],
      ),
    );
  }
}
