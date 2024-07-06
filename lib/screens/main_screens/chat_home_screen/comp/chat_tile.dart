import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/images_path.dart';
import '../../../../constants/text_widget.dart';

class ChatTile extends StatelessWidget {
  ChatTile({super.key,required this.name,required this.chatText,
    required this.lastMsgTime,required this.tapAction,required this.image});

  String name;
  String chatText;
  String lastMsgTime;
  String image;
  VoidCallback tapAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: tapAction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                radius: 3.5.h,
                backgroundColor: lightGreyColor,
                backgroundImage: AssetImage(image),
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width:55.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget1(text: name, fontSize: 20.dp, fontWeight: FontWeight.w600, isTextCenter: false, textColor: themeColor),
                  TextWidget1(text: chatText, fontSize: 11.dp, fontWeight: FontWeight.w300, isTextCenter: false, textColor: textColor),
                ],
              ),
            ),
            TextWidget1(text: lastMsgTime, fontSize: 8.dp, fontWeight: FontWeight.w400, isTextCenter: false, textColor: textColor),
          ],
        ),
      ),
    );
  }
}
