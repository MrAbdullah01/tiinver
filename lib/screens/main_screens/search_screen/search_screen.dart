import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/screens/main_screens/search_screen/comp/searching_tile.dart';
import 'package:tiinver_project/widgets/field_widget.dart';
import 'package:tiinver_project/widgets/header.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("", [
        SizedBox(
          width: 70.w,
          child: InputField(
            autofocus: true,
              hintText: "Search",
              inputController: searchC,
            prefixIcon: Container(
              padding: EdgeInsets.all(14),
                width: 4.w,
                child: Image.asset(ImagesPath.searchingIcon,color: themeColor,fit: BoxFit.cover,)),
            suffixIcon: IconButton(
                onPressed: (){},
                icon: Icon(Icons.cancel,color: themeColor,)),
            bdRadius: 25,
          ),
        ),
        SizedBox(width: 10,),
        SizedBox(
            width: 7.w,
            child: Image.asset(ImagesPath.menuIcon)),
        SizedBox(width: 10,),
      ],
          isIconShow: true),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
        return SearchingTile(
            name: "Dreaming",
            userName: "Dreaming087",
            buttonText: "following",
            buttonAction: (){}
        );
      },),
    );
  }
}
