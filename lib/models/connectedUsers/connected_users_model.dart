class ConnectedUsers {
  final int userId;
  final String? firstname;
  final String? lastname;
  final String username;
  final String profile;

  ConnectedUsers({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.profile,
  });

  factory ConnectedUsers.fromJson(Map<String, dynamic> json) {
    return ConnectedUsers(
      userId: json['userId'],
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      username: json['username'],
      profile: json['profile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'profile': profile,
    };
  }
}
