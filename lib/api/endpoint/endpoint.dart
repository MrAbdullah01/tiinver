import 'package:tiinver_project/api/base/base_urls.dart';

const headers = {
  'Content-Type': 'application/x-www-form-urlencoded',
};
class Endpoint{
  static const forgotPassword = "${BaseUrls.BASEURL}forgotpassword";
  static const geolocation = "${BaseUrls.BASEURL}geolocation";
  static const transfer = "${BaseUrls.BASEURL}transfert";
  static const register = "${BaseUrls.BASEURL}register";
}