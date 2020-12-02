// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GbdUser _$GbdUserFromJson(Map<String, dynamic> json) {
  return GbdUser(
    userName: json['userName'] as String,
    clientToken: json['clientToken'] as String,
    displayName: json['displayName'] as String,
    email: json['email'] as String,
    photoUrl: json['photoUrl'] as String,
  );
}

Map<String, dynamic> _$GbdUserToJson(GbdUser instance) => <String, dynamic>{
      'userName': instance.userName,
      'clientToken': instance.clientToken,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
    };
