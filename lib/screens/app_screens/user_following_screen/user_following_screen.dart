import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/images_path.dart';
import '../../../widgets/header.dart';
import '../search_screen/comp/searching_tile.dart';

class UserFollowingScreen extends StatelessWidget {
  const UserFollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("Following",
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
              name: "Alexandra ", userName: "Alex0789",
              buttonText: "Following", buttonAction: (){}
          );
        },),
    );
  }
}
