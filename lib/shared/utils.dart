import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  static Future<bool?> myToast({required String title})async{

    return await  Fluttertoast.showToast(
        msg: "${title}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManger.kPanfsaji,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }

}