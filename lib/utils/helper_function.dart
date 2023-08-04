import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger
        .of(context)
        .showSnackBar(SnackBar(content: Text(msg)));

String getFormattedTime (DateTime dateTime,String format) =>
    DateFormat(format).format(dateTime);

extension MyExtension on String{
  String capitalize(){
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}
