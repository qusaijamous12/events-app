import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_manger.dart';

Widget myButton({required String title,required onTap}){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 80),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20),
            color: ColorManger.kPanfsaji
        ),
        child: Text(
          '${title}',
          style:const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),

      ),
    ),
  );
}