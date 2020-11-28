import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IssuesData {
  int open;
  int closed;
  double openPercent;
  double closedPercent;

  IssuesData({ this.open, this.closed, this.openPercent, this.closedPercent });


  factory IssuesData.fromJson(Map<String, dynamic> json) => IssuesData(
    open: json["open"],
    closed: json["closed"],
    openPercent: json["openPercent"].toDouble(),
    closedPercent: json["closedPercent"].toDouble(),
  );
}
