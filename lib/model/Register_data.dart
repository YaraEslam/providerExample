import 'dart:convert';

class Register {

  bool success;
  String token;


  Register();


  Register.fromJson(Map<String, dynamic> json) {
    this.token = json["token"];
    this.success = json["success"];
  }

}
