import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../../../constants/images_path.dart';
import '../../../constants/text_widget.dart';
import '../../../widgets/field_widget.dart';
import '../../../widgets/submit_button.dart';
import '../otp_screen/otp_screen.dart';
import '../signin_screen/sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  var emailC = TextEditingController();
  var passwordC = TextEditingController();
  var nameC = TextEditingController();
  var confirmPasswordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      appBar: Header().header1("", [], isIconShow: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          SizedBox(height: 10.h,),
          TextWidget1(text: "Sign Up", fontSize: 20.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: themeColor),
          SizedBox(height: 20,),
          InputField(
            inputController: nameC,
            prefixIcon: Container(
                padding: EdgeInsets.all(24),
                height: 9.h,
                child: Image.asset(ImagesPath.person)),
            hintText: "Full Name",
          ),
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
          SizedBox(height: 20,),
          InputField(
            inputController: confirmPasswordC,
            prefixIcon: Container(
                padding: EdgeInsets.all(24),
                height: 9.h,
                child: Image.asset(ImagesPath.lockIcon)),
            suffixIcon: Icon(Icons.visibility_off_outlined),
            hintText: "Password",
          ),
          SizedBox(height: 70,),
          Center(
            child: SubmitButton(
                radius: 15,
                width: 70.w,
                title: "Sign up",
                press: (){
                  Get.to(()=>OtpScreen());
                }
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget1(text: "Already have an Account?", fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: textColor),
              GestureDetector(
                  onTap: (){
                    Get.to(()=> SignInScreen());
                  },
                  child: TextWidget1(text: "Login", fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: themeColor)),
            ],
          )
        ],
      ),
    );
  }
}
