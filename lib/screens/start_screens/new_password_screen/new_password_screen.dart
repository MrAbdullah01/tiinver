import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/images_path.dart';
import '../../../constants/text_widget.dart';
import '../../../widgets/field_widget.dart';
import '../../../widgets/header.dart';
import '../../../widgets/submit_button.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key});

  var passwordC = TextEditingController();
  var confirmPasswordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("", [], isIconShow: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget1(text: "New Password", fontSize: 20.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: themeColor),
            SizedBox(height: 30,),
            TextWidget1(text: "Please write your new password", fontSize: 16.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: textColor),
            SizedBox(height: 30,),
            InputField(
              inputController: passwordC,
              prefixIcon: Container(
                  padding: EdgeInsets.all(24),
                  height: 9.h,
                  child: Image.asset(ImagesPath.emailIcon)),
              hintText: "Password",
              suffixIcon: Icon(Icons.visibility_off_outlined),
            ),
            SizedBox(height: 30,),
            InputField(
              inputController: confirmPasswordC,
              prefixIcon: Container(
                  padding: EdgeInsets.all(24),
                  height: 9.h,
                  child: Image.asset(ImagesPath.emailIcon)),
              hintText: "Confirm Password",
              suffixIcon: Icon(Icons.visibility_off_outlined),
            ),
            SizedBox(height: 30,),
            Center(
              child: SubmitButton(
                  radius: 15,
                  width: 70.w,
                  title: "Confirm Password",
                  press: (){

                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
