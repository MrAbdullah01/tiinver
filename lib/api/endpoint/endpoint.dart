import 'package:tiinver_project/api/base/base_urls.dart';

const header1 = {
  'Content-Type': 'application/x-www-form-urlencoded',
};
const header2 = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization' : 'c1e3ff561abad9884973836565af1fa7'
};
class Endpoint{
  static const forgotPassword = "${BaseUrls.BASEURL}forgotpassword";
  static const geolocation = "${BaseUrls.BASEURL}geolocation";
  static const transfer = "${BaseUrls.BASEURL}transfert";
  static const register = "${BaseUrls.BASEURL}register";
  static const logout = "${BaseUrls.BASEURL}logout";
  static const deleteAccount = "${BaseUrls.BASEURL}deleteaccount";
  static const subscribeToGroup = "${BaseUrls.BASEURL}group";
  static const deleteGroup = "${BaseUrls.BASEURL}deletegroup";
  static const updateGroup = "${BaseUrls.BASEURL}updategroup";
  static const membership = "${BaseUrls.BASEURL}membership";
  static const groupMessage = "${BaseUrls.BASEURL}group/message";
  static const leftGroup = "${BaseUrls.BASEURL}leftgroup";
  static const updateMember = "${BaseUrls.BASEURL}member/update";
  static const deleteMember = "${BaseUrls.BASEURL}deleteMember";
  static const login = "${BaseUrls.BASEURL}login";
  static const search = "${BaseUrls.BASEURL}usersbykey";
  static const mail = "${BaseUrls.BASEURL}mail";
  static const isPhoneOrEmailExists = "${BaseUrls.BASEURL}isPhoneOrEmailExiste";

  static String followers(int userId, int followerId) {
    return 'https://tiinver.com/api/v1/followers/$userId/$followerId';
  }

  static String following(int userId, int followerId) {
    return 'https://tiinver.com/api/v1/following/$userId/$followerId';
  }

  static String blockUser({
    required String usernameBlocked,
    required String username,
    required String userBlockId,
    required String userID,
  }) {
    return '${BaseUrls.BASEURL}block?username_blocked=$usernameBlocked&username=$username&userId=$userID&user_blocked_id=$userBlockId';
  }

  static const report = "${BaseUrls.BASEURL}report";
  static const updateUser = "${BaseUrls.BASEURL}user";
  static const updateProfile = "${BaseUrls.BASEURL}updateProfile";
  static const updatePassword = "${BaseUrls.BASEURL}updatepassword";
  static const unfollow = "${BaseUrls.BASEURL}unfollow";
  static const follow = "${BaseUrls.BASEURL}follow";
  static const addActivity = "${BaseUrls.BASEURL}addactivity";

}