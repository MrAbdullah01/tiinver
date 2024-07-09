import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/images_path.dart';
import '../../../../constants/text_widget.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 60
      ),
      width: 100.w,
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: themeColor,
                    width: 4
                )
            ),
            child: CircleAvatar(
              radius: 9.h,
              backgroundColor: lightGreyColor,
              backgroundImage: AssetImage(ImagesPath.profileImage),
            ),
          ),
          TextWidget1(text: "Reminder", fontSize: 24.dp, fontWeight: FontWeight.w600, isTextCenter: false, textColor: themeColor),
          TextWidget1(text: "reminder@1234", fontSize: 10.dp, fontWeight: FontWeight.w400, isTextCenter: false, textColor: darkGreyColor),
        ],
      ),
    );
  }
}
