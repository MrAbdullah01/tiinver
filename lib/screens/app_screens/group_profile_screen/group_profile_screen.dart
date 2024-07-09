import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../../../constants/images_path.dart';

class GroupProfileScreen extends StatefulWidget {
  const GroupProfileScreen({super.key});

  @override
  State<GroupProfileScreen> createState() => _GroupProfileScreenState();
}

class _GroupProfileScreenState extends State<GroupProfileScreen> {
  bool isCommentTrue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("English",
          isCenterTitle: true,
          [
            SizedBox(
                width: 7.w,
                child: Image.asset(ImagesPath.menuIcon)),
            SizedBox(width: 15,),
          ],
          isIconShow: true),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: themeColor,
                          width: 4
                      )
                  ),
                  child: CircleAvatar(
                    radius: 10.h,
                    backgroundColor: lightGreyColor,
                    backgroundImage: AssetImage(ImagesPath.profileImage),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: themeColor,
                    shape: BoxShape.circle
                  ),
                  child: Image.asset(ImagesPath.cameraIcon,color: bgColor,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextWidget1(text: "Live Coments", fontSize: 16.dp,
                          fontWeight: FontWeight.w600, isTextCenter: false, textColor: themeColor),
                      const Spacer(),
                      Switch(
                          value: isCommentTrue,
                          inactiveTrackColor: lightGreyColor,
                          inactiveThumbColor: bgColor,

                          onChanged: (value) {
                            setState(() {
                              isCommentTrue = value;
                            });
                          },)
                    ],
                  ),
                  TextWidget1(text: "Link Description group", fontSize: 13.dp,
                      fontWeight: FontWeight.w600, isTextCenter: false, textColor: textColor),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: themeColor,
                            shape: BoxShape.circle
                        ),
                        child: Icon(CupertinoIcons.link,color: bgColor,),
                      ),
                      SizedBox(width: 20,),
                      TextWidget1(text: "Invitation Link", fontSize: 16.dp,
                          fontWeight: FontWeight.w600, isTextCenter: false, textColor: themeColor),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
