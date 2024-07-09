import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/screens/app_screens/group_creation_screen/group_creation_screen.dart';
import 'package:tiinver_project/widgets/field_widget.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../../../constants/images_path.dart';

class InviteContactScreen extends StatelessWidget {
  InviteContactScreen({super.key});

  var searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("Contacts",
          [
            SizedBox(
                width: 7.w,
                child: Image.asset(ImagesPath.menuIcon)),
            SizedBox(width: 15,),
          ],
          isIconShow: true, isCenterTitle: true),
      body:  Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeColor,
                    shape: BoxShape.circle
                  ),
                  child: Image.asset(ImagesPath.addUserIcon),
                ),
                SizedBox(width: 20,),
                TextWidget1(text: "Create Group", fontSize: 24.dp, fontWeight: FontWeight.w700, isTextCenter: false, textColor: themeColor)
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            width: 100.w,
            decoration: BoxDecoration(
              color: tileColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search,color: darkGreyColor,),
                SizedBox(
                  width: 70.w,
                  child: InputField(
                      inputController: searchC,
                    hintText: "Search in Tiinver",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 3.5.h,
                      backgroundImage: AssetImage(ImagesPath.profileImage),
                    ),
                    title: TextWidget1(text: "Alexandra", fontSize: 16.dp,
                        fontWeight: FontWeight.w600, isTextCenter: false, textColor: themeColor),
                    subtitle: TextWidget1(text: "Alex@73456", fontSize: 12.dp,
                        fontWeight: FontWeight.w600, isTextCenter: false, textColor: darkGreyColor),
                  ),
                );
              },),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset(ImagesPath.sendIcon,color: bgColor),
        ),
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupCreationScreen()));
          }
      ),
    );
  }
}
