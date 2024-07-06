import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/widgets/submit_button.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/images_path.dart';
import '../../../../constants/text_widget.dart';

class SearchingTile extends StatelessWidget {
  SearchingTile({super.key,required this.name,required this.userName,
    required this.buttonText,required this.buttonAction});

  String name;
  String userName;
  String buttonText;
  VoidCallback buttonAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 4.h,
            backgroundImage: AssetImage(ImagesPath.profileImage),
          ),
          SizedBox(width: 10,),
          SizedBox(
            width:55.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget1(text: name, fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: textColor),
                TextWidget1(text: userName, fontSize: 11.dp, fontWeight: FontWeight.w300, isTextCenter: false, textColor: textColor),
              ],
            ),
          ),
          SubmitButton(
            height: 3.h,
              width: 17.w,
              textSize: 10.dp,
              radius: 5,
              title: buttonText,
              press: buttonAction
          )
        ],
      ),
    );
  }
}
