import 'package:cloud_firestore/cloud_firestore.dart';

class TokenModel {
  String? token;
  FieldValue? creadtedAt;

  TokenModel({this.token, this.creadtedAt});

  TokenModel.fromData(Map<String, dynamic> data)
      : token = data['token'],
        creadtedAt = data['createdAt'];

  static TokenModel? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return TokenModel(token: map['token'], creadtedAt: map['createdAt']);
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'createdAt': creadtedAt};
  }
}
