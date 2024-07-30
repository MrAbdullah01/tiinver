import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/screens/app_screens/group_chat_screen/group_chat_screen.dart';
import 'package:tiinver_project/screens/app_screens/invite_contact_screen/invite_contact_screen.dart';
import 'package:tiinver_project/screens/app_screens/msg_screen/msg_screen.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../../../constants/images_path.dart';
import '../../../constants/text_widget.dart';
import '../chat_screen/chat_screen.dart';
import '../tiinver_ai_chat/tiinver_ai_chat.dart';
import 'comp/chat_tile.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("Chats", [
        PopupMenuButton(
          surfaceTintColor: bgColor,
          color: bgColor,
          child: SizedBox(
              width: 7.w,
              child: Image.asset(ImagesPath.menuIcon)),
          itemBuilder: (context) =>[
            PopupMenuItem(
              onTap: (){
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context)=>ReportScreen()));
              },
              value: 'Item 1',
              child: TextWidget1(text: "New Message", fontSize: 16.dp,
                  fontWeight: FontWeight.w700, isTextCenter: false, textColor: themeColor),),
          ],),
        SizedBox(width: 15,),
      ],isCenterTitle: true, isIconShow: false),
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
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              print("tap");
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MsgScreen()));
            },
            child: Row(
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
          ),
          SizedBox(height: 10,),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              Get.to(()=>InviteContactScreen());
            },
            child: Row(
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
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
          ),
          child: Image.asset(ImagesPath.addUserIcon,height: 3.h,),
          backgroundColor: themeColor,
          onPressed: (){
            Get.to(()=>GroupChatScreen());
          }
      ),
    );
  }
}
