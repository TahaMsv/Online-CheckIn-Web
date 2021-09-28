class User {
  User({
    this.token,
    this.userId,
  });

  String? token;
  int? userId;

  factory User.fromJson(Map<String, dynamic> json) => User(
    token: json["Token"],
    userId: json["UserID"],
  );

  Map<String, dynamic> toJson() => {
    "Token": token,
    "UserID": userId,
  };
}