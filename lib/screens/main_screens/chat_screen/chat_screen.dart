import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/images_path.dart';
import '../../../constants/text_widget.dart';
import '../../../widgets/field_widget.dart';
import '../../../widgets/header.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  var msgC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("user chat", [], isIconShow: true,isCenterTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: TextWidget1(text: "Hello, how can i help you?", fontSize: 20.dp, fontWeight: FontWeight.w600, isTextCenter: false, textColor: themeColor))
        ],
      ),
      floatingActionButton: Container(
        color: tileColor,
        padding: EdgeInsets.only(bottom: 0),
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 65.w,
                child: InputField(
                  inputController: msgC,
                  hintText: "messag...",
                  bdRadius: 0,
                )),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    height: 8.h,
                    child: Image.asset(msgC.text.isEmpty ? ImagesPath.editIcon : ImagesPath.voiceIcon)),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    height: 8.h,
                    child: Image.asset(ImagesPath.galleryIcon)),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    height: 8.h,
                    child: Image.asset(ImagesPath.sendIcon)),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
