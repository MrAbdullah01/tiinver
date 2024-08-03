// global_keys.dart or in main.dart
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/providers/signIn/sign_in_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();



class GlobalProviderAccess {
  static SignInProvider? get signProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<SignInProvider>(context, listen: false);
    }
    return null;
  }

  // static SignInProvider? get secondProvider {
  //   final context = navigatorKey.currentContext;
  //   if (context != null) {
  //     return Provider.of<SignInProvider>(context, listen: false);
  //   }
  //   return null;
  // }
}
