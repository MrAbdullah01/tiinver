import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/providers/search/search_provider.dart';
import 'package:tiinver_project/providers/signIn/sign_in_provider.dart';
import 'package:tiinver_project/widgets/header.dart';

import 'comp/searching_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var signInP = Provider.of<SignInProvider>(context,listen: false);
    var searchP = Provider.of<SearchProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("", [
        SizedBox(
          width: 70.w,
          child: TextFormField(
            onChanged: (value){
              if(searchP.searchC.text.isNotEmpty){
                searchP.searchUsers(key: value,userApiKey: signInP.userApiKey.toString());
              }
            },
            validator: (value) {
              if(value!.isEmpty){
                return "Enter the Field";
              }else{
                return null;
              }
            },
            maxLines: 1,
            textInputAction: TextInputAction.done,
            autofocus: true,
            style: TextStyle(
              fontSize: 12.dp,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: themeColor,
            controller: searchP.searchC,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              prefixIcon: Container(
                     padding: EdgeInsets.all(14),
                       width: 4.w,
                       child: Image.asset(ImagesPath.searchingIcon,color: themeColor,fit: BoxFit.cover,)),
              suffixIcon: IconButton(
                       onPressed: (){
                         searchP.clearSearch();
                       },
                       icon: Icon(Icons.cancel,color: themeColor,)),
              suffixIconColor: darkGreyColor,
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              fillColor: tileColor,
              filled: true,
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderSide:  BorderSide(
                  color: tileColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(
                  color: tileColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:  BorderSide(
                  color: tileColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          )
        ),
        SizedBox(width: 10,),
        SizedBox(
            width: 7.w,
            child: Image.asset(ImagesPath.menuIcon)),
        SizedBox(width: 10,),
      ],
          isIconShow: true),
      body: FutureBuilder(
        future: searchP.searchUsers(
            key: searchP.searchC.text,
            userApiKey: signInP.userApiKey.toString()
        ),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting?
        Center(child: CircularProgressIndicator())
        : Consumer<SearchProvider>(builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.users.length,
            itemBuilder: (context, index) {
              var user = value.users[index];
              return SearchingTile(
                name: user.firstname ?? '',
                userName: user.username ?? '',
                buttonText: user.isFollowed! ? "following" : "follow",
                buttonAction: (){},
                imageUrl: user.profile.toString(),
              );
            },);
        },)
      ),
    );
  }
}
