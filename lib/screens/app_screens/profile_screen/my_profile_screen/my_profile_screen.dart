import 'package:flutter/material.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/screens/app_screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:tiinver_project/screens/app_screens/exchange_coin_screen/exchange_coin_screen.dart';
import 'package:tiinver_project/screens/app_screens/wallet_screen/wallet_screen.dart';

import '../comp/profile_data_tile.dart';
import '../comp/profile_editor_button.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

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
          ProfileDataTile(icon: ImagesPath.personIcon,title: "Lelsi Alexandra",),
          ProfileDataTile(icon: ImagesPath.personIcon,title: "Design @inspiration",),
          ProfileDataTile(icon: ImagesPath.phoneIcon,title: "+92 123 456 789 0",),
          ProfileDataTile(icon: ImagesPath.emailIcon,title: "lelsi.do@gmail.com",),
          ProfileDataTile(icon: ImagesPath.locationIcon,title: "New york house # 34",),
          ProfileDataTile(icon: ImagesPath.businessIcon,title: "Work at",),
          ProfileDataTile(icon: ImagesPath.qualificationIcon,title: "Qualification",),
          ProfileDataTile(icon: ImagesPath.educationIcon,title: "School / Collage",),
        ],
      ),
    );
  }
}
