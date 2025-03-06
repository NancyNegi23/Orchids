import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? email;
  String? userUid;
  Timestamp? time;
  String? phone;
  bool? accVerified;
  String? address;
  String? name;

  Users(
      {this.email,
      this.name,
      this.userUid,
      this.phone,
      this.accVerified,
      this.address,
      this.time});

  Users.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userUid = json['userUid'];
    phone = json['phone'];
    name = json['name'];

    address = json['address'];
    accVerified = json['accVerified'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['userUid'] = userUid;
    data['address'] = address;
    data['phone'] = phone;
    data['time'] = time;
    data['accVerified'] = accVerified;
    return data;
  }
}
