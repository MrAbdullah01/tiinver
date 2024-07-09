import 'package:flutter/cupertino.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_widget.dart';
import '../../../../widgets/submit_button.dart';

class FollowingStatus extends StatelessWidget {
  const FollowingStatus({super.key,this.followNumber,this.icon,this.buttonText,this.followText});

  final String? followNumber;
  final String? followText;
  final String? buttonText;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidget1(text: followNumber!, fontSize: 20.dp, fontWeight: FontWeight.w600, isTextCenter: false, textColor: themeColor),
        TextWidget1(text: followText!, fontSize: 20.dp, fontWeight: FontWeight.w600, isTextCenter: false, textColor: darkGreyColor),
        SubmitButton(
            height: 2.h,
            width: 18.w,
            textSize: 10.dp,
            iconSize: 10,
            title: buttonText,
            icon: icon,
            press: (){}
        )
      ],
    );
  }
}
