import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class GbdUser {
  final String userName;
  final String clientToken;
  final String displayName;
  final String email;
  final String photoUrl;

  GbdUser(
      {@required this.userName,
      @required this.clientToken,
      @required this.displayName,
      @required this.email,
      @required this.photoUrl});

  factory GbdUser.fromJson(Map<String, dynamic> json) => _$GbdUserFromJson(json);
  Map<String, dynamic> toJson() => _$GbdUserToJson(this);
 
}
