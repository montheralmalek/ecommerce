class LoginResponse {
  final String token;
  LoginResponse({required this.token});
  Map<String, dynamic> toJson() {
    return {'token': token};
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(token: json['token'] as String);
  }
}
