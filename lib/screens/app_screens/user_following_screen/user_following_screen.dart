import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/images_path.dart';
import '../../../providers/updateProfile/update_profile_provider.dart';
import '../../../widgets/header.dart';
import '../search_screen/comp/searching_tile.dart';

class UserFollowingScreen extends StatelessWidget {
  const UserFollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var updateP = Provider.of<UpdateProfileProvider>(context, listen: false);
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
      body: FutureBuilder(
        future: Provider.of<UpdateProfileProvider>(context, listen: false).followers(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<UpdateProfileProvider>(
          builder: (ctx, userProvider, child) => ListView.builder(
            itemCount: updateP.followersList.length,
            itemBuilder: (context, index) {
              return SearchingTile(
                  name: '${userProvider.followersList[index].firstname} ${userProvider.followersList[index].lastname}',
                  userName: userProvider.followersList[index].username.toString(),
                  imageUrl: userProvider.followersList[index].profile.toString(),
                  buttonText: "Follow Back", buttonAction: (){}
              );
            },),
        ),
      ),
    );
  }
}
