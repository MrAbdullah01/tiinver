import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/widgets/header.dart';
import 'package:tiinver_project/widgets/submit_button.dart';

import 'comp/edit_profile_tile.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("", [], isIconShow: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 8.h,
                    backgroundColor: lightGreyColor,
                    backgroundImage: AssetImage(ImagesPath.profileImage),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: themeColor,
                        shape: BoxShape.circle
                    ),
                    child: Image.asset(ImagesPath.cameraIcon,color: bgColor,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            EditProfileTile(
              image: ImagesPath.personIcon,
              text: "Full Name",
              controller: controller,
            ),
            EditProfileTile(
              image: ImagesPath.locationIcon,
              text: "Location",
              controller: controller,
            ),
            EditProfileTile(
              image: ImagesPath.businessIcon,
              text: "Work at",
              controller: controller,
            ),
            EditProfileTile(
              image: ImagesPath.qualificationIcon,
              text: "Qualification",
              controller: controller,
            ),
            EditProfileTile(
              image: ImagesPath.educationIcon,
              text: "School / Collage",
              controller: controller,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SubmitButton(
                  width: 40.w,
                    title: "Save",
                    press: (){}
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
