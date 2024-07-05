import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/widgets/header.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header2("Tiinver", [
            SizedBox(
                width: 7.w,
                child: Image.asset(ImagesPath.searching)),
            SizedBox(width: 10,),
            SizedBox(
                width: 7.w,
                child: Image.asset(ImagesPath.menu)),
            SizedBox(width: 15,),
          ]),
      body: GridView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Image.asset(ImagesPath.dashBoardImage),
          );
        }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

      ),
    );
  }
}
