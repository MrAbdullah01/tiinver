import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/screens/app_screens/search_screen/comp/searching_tile.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../../../constants/images_path.dart';

class UserFollowersScreen extends StatelessWidget {
  const UserFollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("Followers",
          [
            SizedBox(
                width: 7.w,
                child: Image.asset(ImagesPath.menuIcon)),
            SizedBox(width: 15,),
          ],
          isCenterTitle: true,
          isIconShow: true),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
        return SearchingTile(
            name: "Dreaming", userName: "Dreaming078",
            buttonText: "Follow Back", buttonAction: (){}
        );
      },),
    );
  }
}
