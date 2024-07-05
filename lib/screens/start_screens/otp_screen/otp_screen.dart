import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:pinput/pinput.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/widgets/header.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: true,
      // appBar: Header().header("", []),
      appBar: AppBar(
        surfaceTintColor: bgColor,
        backgroundColor: bgColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextWidget1(text: "Enter the Code", fontSize: 24.dp, fontWeight: FontWeight.w600, isTextCenter: false, textColor: textColor),
          SizedBox(height: 30,),
          TextWidget1(text: "We have emailed you an activation code", fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: darkGreyColor),
          SizedBox(height: 30,),
          Center(
            child: Pinput(
              onTapOutside: (value){
                FocusScope.of(context).unfocus();
              },
              length: 4,
              onCompleted: (pin) => print('Entered PIN: $pin'),
              defaultPinTheme: PinTheme(
                width: 20.w,
                height: 56,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lightGreyColor),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          TextWidget1(text: "Tiinver will send the code to you in : 1:00", fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: darkGreyColor),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 63.w,
                  child: TextWidget1(text: "If you have not received the code", fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: darkGreyColor,maxLines: 2,)),
              SizedBox(
                  width: 20.w,
                  child: Center(child: TextWidget1(text: "Click here", fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: themeColor))),
            ],
          ),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: lightGreyColor
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 8.w,
                      child: Image.asset(ImagesPath.warning)),
                  SizedBox(width: 5,),
                  SizedBox(
                      width: 70.w,
                      child: TextWidget1(text: "If the message is not in your inbox please check spam.", fontSize: 16.dp, fontWeight: FontWeight.w400, isTextCenter: false, textColor: themeColor,maxLines: 2,)),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
