import 'package:json_annotation/json_annotation.dart';
import 'package:test_android_flutter/core/models/geo.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
