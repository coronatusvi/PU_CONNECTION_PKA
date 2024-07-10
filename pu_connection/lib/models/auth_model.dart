// auth_model.dart

class AuthModel {
  final String? userId;
  final String? accessToken;

  AuthModel({this.userId, this.accessToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userId: json['userId'],
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'accessToken': accessToken,
    };
  }
}
