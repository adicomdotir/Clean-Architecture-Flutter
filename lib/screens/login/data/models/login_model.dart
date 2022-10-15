import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';

class LoginModel extends Login {
  LoginModel({required String? token}) : super(token: token);

  factory LoginModel.fromJson(Map<String, dynamic> jsonMap) {
    return LoginModel(token: jsonMap["token"]);
  }

  Map<String, dynamic> toJson() {
    return {"token": token};
  }
}
