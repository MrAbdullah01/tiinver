import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/providers/updateProfile/update_profile_provider.dart';
import 'package:tiinver_project/widgets/header.dart';
import 'package:tiinver_project/widgets/submit_button.dart';

import '../../../providers/signIn/sign_in_provider.dart';
import 'comp/edit_profile_tile.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var workController = TextEditingController();
  var qualificationController = TextEditingController();
  var schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context, listen: false);
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
                    backgroundImage: provider.user != null ? NetworkImage(provider.user!.user!.profile.toString()) : AssetImage(ImagesPath.profileImage),
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
              hint: provider.user !=null ? nameController.text = provider.user!.user!.firstname.toString() : "Full Name",
              controller: nameController,
            ),
            EditProfileTile(
              image: ImagesPath.locationIcon,
              text: "Location",
              hint: provider.user !=null ? locationController.text = provider.user!.user!.location.toString() : "Location",
              controller: locationController,
            ),
            EditProfileTile(
              image: ImagesPath.businessIcon,
              text: "Work at",
              hint: provider.user !=null ? workController.text = provider.user!.user!.work.toString() : "Work",
              controller: workController,
            ),
            EditProfileTile(
              image: ImagesPath.qualificationIcon,
              text: "Qualification",
              hint: provider.user !=null ?
              qualificationController.text = provider.user!.user!.qualification.toString() : "Qualification",
              controller: qualificationController,
            ),
            EditProfileTile(
              image: ImagesPath.educationIcon,
              text: "School / Collage",
              hint: provider.user !=null ?
              schoolController.text = provider.user!.user!.school.toString() : "School",
              controller: schoolController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SubmitButton(
                  width: 40.w,
                    title: "Save",
                    press: (){

                    Provider.of<UpdateProfileProvider>(context,listen: false)
                        .updateProfile(
                        id: provider.user!.user!.id.toString(),
                        name: nameController.text,
                        qualification: qualificationController.text,
                        workAt: workController.text,
                        school: schoolController.text,
                        location: locationController.text
                    );

                    }
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
