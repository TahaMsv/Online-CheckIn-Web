class RequestModelLogin {
  final String username;
  final String password;

  RequestModelLogin({required this.username,required this.password});

  factory RequestModelLogin.fromJson(Map<String, dynamic> json) => RequestModelLogin(
    username: json["Username"],
    password: json["Password"],
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
    "Password": password,
  };
}