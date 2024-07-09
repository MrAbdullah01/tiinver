import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/providers/onboard_provider/onboard_provider.dart';
import 'package:tiinver_project/screens/auth_screens/splash_screen/splash_screen.dart';

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
          ],
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tiinver',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: themeColor,primary: themeColor),
                useMaterial3: true,
              ),
              home: const SplashScreen(),
            ),
          );
        }
    );
  }
}

