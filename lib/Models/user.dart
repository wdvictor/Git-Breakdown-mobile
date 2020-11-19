import 'package:flutter/material.dart';

class GbdUser {
  final String clientToken;
  final String displayName;
  final String email;
  final String photoUrl;

  GbdUser(
      {@required this.clientToken,
      @required this.displayName,
      @required this.email,
      @required this.photoUrl});
}
