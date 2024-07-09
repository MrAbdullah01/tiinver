import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/widgets/field_widget.dart';
import 'package:tiinver_project/widgets/header.dart';
import 'package:tiinver_project/widgets/submit_button.dart';

import '../../app_screens/bottom_navbar_screen/bottom_navbar_screen.dart';
import '../forget_password_screen/forget_password_screen.dart';
import '../onboarding_screen/comp/navigate_button.dart';
import '../sign_up_screen/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  var emailC = TextEditingController();
  var passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("", [], isIconShow: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget1(text: "Sign In", fontSize: 20.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: themeColor),
            SizedBox(height: 20,),
            InputField(
              inputController: emailC,
              prefixIcon: Container(
                  padding: EdgeInsets.all(24),
                  height: 9.h,
                  child: Image.asset(ImagesPath.emailIcon)),
              hintText: "Email",
            ),
            SizedBox(height: 20,),
            InputField(
              inputController: passwordC,

              prefixIcon: Container(
                padding: EdgeInsets.all(24),
                  height: 9.h,
                  child: Image.asset(ImagesPath.lockIcon)),
              suffixIcon: Icon(Icons.visibility_off_outlined),
              hintText: "Password",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(()=>ForgetPasswordScreen());
                  },
                  child: SizedBox(
                      height: 30,
                      child: Center(child: TextWidget1(text: "Forget Password?", fontSize: 12.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: themeColor))),
                ),
              ],
            ),
            SizedBox(height: 70,),
            Center(
              child: SubmitButton(
                radius: 15,
                width: 70.w,
                  title: "Sign in",
                  press: (){
                  Get.to(()=>BottomNavbarScreen());
                  }
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget1(text: "New User?", fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: textColor),
                GestureDetector(
                    onTap: (){
                      Get.to(()=> SignUpScreen());
                    },
                    child: TextWidget1(text: "Register Now", fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: themeColor)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
