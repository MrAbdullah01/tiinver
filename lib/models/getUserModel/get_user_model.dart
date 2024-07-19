// To parse this JSON data, do
//
//     final getUserModel = getUserModelFromJson(jsonString);

import 'dart:convert';

List<GetUserModel> getUserModelFromJson(String str) => List<GetUserModel>.from(json.decode(str).map((x) => GetUserModel.fromJson(x)));

String getUserModelToJson(List<GetUserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUserModel {
  bool error;
  UserData userData;

  GetUserModel({
    required this.error,
    required this.userData,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
    error: json["error"],
    userData: UserData.fromJson(json["userData"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "userData": userData.toJson(),
  };
}

class UserData {
  int id;
  String type;
  String firstname;
  String lastname;
  String username;
  int followers;
  int following;
  String verify;
  String active;
  String profile;
  String location;
  String school;
  String qualification;
  String birthday;
  String work;
  int coinsAmount;
  String stamp;

  UserData({
    required this.id,
    required this.type,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.followers,
    required this.following,
    required this.verify,
    required this.active,
    required this.profile,
    required this.location,
    required this.school,
    required this.qualification,
    required this.birthday,
    required this.work,
    required this.coinsAmount,
    required this.stamp,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"] ?? "",
    type: json["type"],
    firstname: json["firstname"] ?? "",
    lastname: json["lastname"] ?? "",
    username: json["username"] ?? "",
    followers: json["followers"] ?? "",
    following: json["following"] ?? "",
    verify: json["verify"] ?? "",
    active: json["active"] ?? "",
    profile: json["profile"] ?? "",
    location: json["location"] ?? "",
    school: json["school"] ?? "",
    qualification: json["qualification"] ?? "",
    birthday: json["birthday"] ?? "",
    work: json["work"] ?? "",
    coinsAmount: json["coinsAmount"] ?? "",
    stamp: json["stamp"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "firstname": firstname,
    "lastname": lastname,
    "username": username,
    "followers": followers,
    "following": following,
    "verify": verify,
    "active": active,
    "profile": profile,
    "location": location,
    "school": school,
    "qualification": qualification,
    "birthday": birthday,
    "work": work,
    "coinsAmount": coinsAmount,
    "stamp": stamp,
  };
}
