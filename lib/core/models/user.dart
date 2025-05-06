import 'package:json_annotation/json_annotation.dart';
import 'package:test_android_flutter/core/models/address.dart';
import 'package:test_android_flutter/core/models/company.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
