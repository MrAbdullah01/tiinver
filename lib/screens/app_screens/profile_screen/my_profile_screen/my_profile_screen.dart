import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/images_path.dart';
import 'package:tiinver_project/models/getUserModel/get_user_model.dart';
import 'package:tiinver_project/models/login/user_login_model.dart';
import 'package:tiinver_project/providers/profile/profile_provider.dart';
import 'package:tiinver_project/providers/signIn/sign_in_provider.dart';
import 'package:tiinver_project/screens/app_screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:tiinver_project/screens/app_screens/exchange_coin_screen/exchange_coin_screen.dart';
import 'package:tiinver_project/screens/app_screens/wallet_screen/wallet_screen.dart';
import '../comp/profile_data_tile.dart';
import '../comp/profile_editor_button.dart';

class MyProfileScreen extends StatelessWidget {
  final GetUserModel model1;
  final UserLoginModel model2;
  const MyProfileScreen({super.key, required this.model2, required this.model1,});
  // required this.model1, required this.model2,
  @override
  Widget build(BuildContext context) {
    var profileP = Provider.of<ProfileProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      body: Consumer<ProfileProvider>(builder: (context, value, child) {
        return ListView(
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
            ProfileDataTile(icon: ImagesPath.personIcon,title: model1.userData.firstname),
            ProfileDataTile(icon: ImagesPath.personIcon,title: model1.userData.username),
            ProfileDataTile(icon: ImagesPath.phoneIcon,title: model2.user!.phone,),
            ProfileDataTile(icon: ImagesPath.emailIcon,title: model2.user!.email),
            ProfileDataTile(icon: ImagesPath.locationIcon,title: model1.userData.location),
            ProfileDataTile(icon: ImagesPath.businessIcon,title: model1.userData.work,),
            ProfileDataTile(icon: ImagesPath.qualificationIcon,title: model1.userData.qualification),
            ProfileDataTile(icon: ImagesPath.educationIcon,title: model1.userData.school),
          ],
        );
      },),
    );
  }
}
