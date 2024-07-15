import 'package:flutter/material.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/models/login/user_login_model.dart';
import 'package:tiinver_project/screens/app_screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:tiinver_project/screens/app_screens/exchange_coin_screen/exchange_coin_screen.dart';
import 'package:tiinver_project/screens/app_screens/wallet_screen/wallet_screen.dart';

import '../comp/profile_data_tile.dart';
import '../comp/profile_editor_button.dart';

class MyProfileScreen extends StatelessWidget {
  final UserLoginModel model;
  const MyProfileScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileEditorButton(
                image: ImagesPath.addIcon,
                text: "Add",boxColor: darkGreyColor,
                onTap: (){},
              ),
              ProfileEditorButton(
                image: ImagesPath.profileEditIcon,
                text: "Edit",boxColor: themeColor,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(),));
                },
              ),
              ProfileEditorButton(
                image: ImagesPath.walletIcon,
                text: "Wallet",boxColor: themeColor,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen(),));
                },
              ),
              ProfileEditorButton(
                image: ImagesPath.exchangeIcon,
                text: "Exchange",boxColor: themeColor,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExchangeCoinScreen(),));
                },
              ),
            ],
          ),
          SizedBox(height: 20,),
          ProfileDataTile(icon: ImagesPath.personIcon,title: model.user!.firstname),
          ProfileDataTile(icon: ImagesPath.personIcon,title: model.user!.username),
          ProfileDataTile(icon: ImagesPath.phoneIcon,title: model.user!.phone,),
          ProfileDataTile(icon: ImagesPath.emailIcon,title: model.user!.email),
          ProfileDataTile(icon: ImagesPath.locationIcon,title: model.user!.location),
          ProfileDataTile(icon: ImagesPath.businessIcon,title: model.user!.work,),
          ProfileDataTile(icon: ImagesPath.qualificationIcon,title: model.user!.qualification),
          ProfileDataTile(icon: ImagesPath.educationIcon,title: model.user!.school),
        ],
      ),
    );
  }
}
