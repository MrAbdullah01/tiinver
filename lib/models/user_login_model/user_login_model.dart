class UserLoginModel {
  UserLoginModel({
    bool? error,
    String? message,
    UserSignIn? user,
  }) {
    _error = error;
    _message = message;
    _user = user;
  }

  UserLoginModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _user = json['user'] != null ? UserSignIn.fromJson(json['user']) : null;
  }

  bool? _error;
  String? _message;
  UserSignIn? _user;

  UserLoginModel copyWith({
    bool? error,
    String? message,
    UserSignIn? user,
  }) =>
      UserLoginModel(
        error: error ?? _error,
        message: message ?? _message,
        user: user ?? _user,
      );

  bool? get error => _error;
  String? get message => _message;
  UserSignIn? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class UserSignIn {
  UserSignIn({
    num? id,
    String? apiKey,
    String? email,
    dynamic phone,
    String? subscribe,
    List<dynamic>? blockedUsers,
    String? type,
    String? username,
    String? firstname,
    dynamic lastname,
    String? profile,
    String? verify,
    String? active,
    num? followers,
    num? following,
    dynamic location,
    dynamic school,
    String? qualification,
    String? birthday,
    dynamic work,
    num? coinsAmount,
    String? stamp,
  }) {
    _id = id;
    _apiKey = apiKey;
    _email = email;
    _phone = phone;
    _subscribe = subscribe;
    _blockedUsers = blockedUsers;
    _type = type;
    _username = username;
    _firstname = firstname;
    _lastname = lastname;
    _profile = profile;
    _verify = verify;
    _active = active;
    _followers = followers;
    _following = following;
    _location = location;
    _school = school;
    _qualification = qualification;
    _birthday = birthday;
    _work = work;
    _coinsAmount = coinsAmount;
    _stamp = stamp;
  }

  UserSignIn.fromJson(dynamic json) {
    _id = json['id'];
    _apiKey = json['apiKey'];
    _email = json['email'];
    _phone = json['phone'];
    _subscribe = json['subscribe'];
    _blockedUsers = json['blocked_users'] != null ? List<dynamic>.from(json['blocked_users']) : null;
    _type = json['type'];
    _username = json['username'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _profile = json['profile'];
    _verify = json['verify'];
    _active = json['active'];
    _followers = json['followers'];
    _following = json['following'];
    _location = json['location'];
    _school = json['school'];
    _qualification = json['qualification'];
    _birthday = json['birthday'];
    _work = json['work'];
    _coinsAmount = json['coinsAmount'];
    _stamp = json['stamp'];
  }

  num? _id;
  String? _apiKey;
  String? _email;
  dynamic _phone;
  String? _subscribe;
  List<dynamic>? _blockedUsers;
  String? _type;
  String? _username;
  String? _firstname;
  dynamic _lastname;
  String? _profile;
  String? _verify;
  String? _active;
  num? _followers;
  num? _following;
  dynamic _location;
  dynamic _school;
  String? _qualification;
  String? _birthday;
  dynamic _work;
  num? _coinsAmount;
  String? _stamp;

  UserSignIn copyWith({
    num? id,
    String? apiKey,
    String? email,
    dynamic phone,
    String? subscribe,
    List<dynamic>? blockedUsers,
    String? type,
    String? username,
    String? firstname,
    dynamic lastname,
    String? profile,
    String? verify,
    String? active,
    num? followers,
    num? following,
    dynamic location,
    dynamic school,
    String? qualification,
    String? birthday,
    dynamic work,
    num? coinsAmount,
    String? stamp,
  }) =>
      UserSignIn(
        id: id ?? _id,
        apiKey: apiKey ?? _apiKey,
        email: email ?? _email,
        phone: phone ?? _phone,
        subscribe: subscribe ?? _subscribe,
        blockedUsers: blockedUsers ?? _blockedUsers,
        type: type ?? _type,
        username: username ?? _username,
        firstname: firstname ?? _firstname,
        lastname: lastname ?? _lastname,
        profile: profile ?? _profile,
        verify: verify ?? _verify,
        active: active ?? _active,
        followers: followers ?? _followers,
        following: following ?? _following,
        location: location ?? _location,
        school: school ?? _school,
        qualification: qualification ?? _qualification,
        birthday: birthday ?? _birthday,
        work: work ?? _work,
        coinsAmount: coinsAmount ?? _coinsAmount,
        stamp: stamp ?? _stamp,
      );

  num? get id => _id;
  String? get apiKey => _apiKey;
  String? get email => _email;
  dynamic get phone => _phone;
  String? get subscribe => _subscribe;
  List<dynamic>? get blockedUsers => _blockedUsers;
  String? get type => _type;
  String? get username => _username;
  String? get firstname => _firstname;
  dynamic get lastname => _lastname;
  String? get profile => _profile;
  String? get verify => _verify;
  String? get active => _active;
  num? get followers => _followers;
  num? get following => _following;
  dynamic get location => _location;
  dynamic get school => _school;
  String? get qualification => _qualification;
  String? get birthday => _birthday;
  dynamic get work => _work;
  num? get coinsAmount => _coinsAmount;
  String? get stamp => _stamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['apiKey'] = _apiKey;
    map['email'] = _email;
    map['phone'] = _phone;
    map['subscribe'] = _subscribe;
    if (_blockedUsers != null) {
      map['blocked_users'] = _blockedUsers;
    }
    map['type'] = _type;
    map['username'] = _username;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['profile'] = _profile;
    map['verify'] = _verify;
    map['active'] = _active;
    map['followers'] = _followers;
    map['following'] = _following;
    map['location'] = _location;
    map['school'] = _school;
    map['qualification'] = _qualification;
    map['birthday'] = _birthday;
    map['work'] = _work;
    map['coinsAmount'] = _coinsAmount;
    map['stamp'] = _stamp;
    return map;
  }
}
