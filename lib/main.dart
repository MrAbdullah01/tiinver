import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/providers/forgot/forgot_provider.dart';
import 'package:tiinver_project/providers/onboard/onboard_provider.dart';
import 'package:tiinver_project/providers/otp/otp_provider.dart';
import 'package:tiinver_project/providers/signIn/sign_in_provider.dart';
import 'package:tiinver_project/providers/signUp/sign_up_provider.dart';
import 'package:tiinver_project/providers/updateProfile/update_profile_provider.dart';
import 'package:tiinver_project/routes/routes.dart';
import 'package:tiinver_project/routes/routes_name.dart';

import 'constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
        builder: (context, orientation, screenType) {
          return MultiProvider(
              providers: [
            ChangeNotifierProvider(create: (_)=> OnboardProvider()),
            ChangeNotifierProvider(create: (_)=> SignInProvider()),
            ChangeNotifierProvider(create: (_)=> SignUpProvider()),
            ChangeNotifierProvider(create: (_)=> ForgotProvider()),
            ChangeNotifierProvider(create: (_)=> OtpProvider()),
            ChangeNotifierProvider(create: (_)=> UpdateProfileProvider()),
          ],
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tiinver',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: themeColor,primary: themeColor),
                useMaterial3: true,
              ),
              initialRoute: RoutesName.splashScreen,
              getPages: Routes.routes,
            ),
          );
        }
    );
  }
}

