import 'package:edu_events/presentaion_layer/login_screen/login_screen.dart';
import 'package:edu_events/presentaion_layer/register_screen/register_screen.dart';
import 'package:edu_events/presentaion_layer/resources/button_manger.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png',height: 450,),
              const  Text(
                'Hello',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: ColorManger.kPanfsaji
                ),
              ),
              const Text(
                'We Are Welcomed with You in Our App Lets Start to Join Event and WorkShops',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              myButton(title: 'Sign In', onTap: (){
                Get.offAll(()=>const LoginScreen());
              }),
              const SizedBox(
                height: 15,
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: GestureDetector(
                  onTap: (){
                    Get.offAll(()=>const RegisterScreen());
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(20),
                        color: Colors.white,
                      border: Border.all(
                        color: ColorManger.kPanfsaji
                      )
                    ),
                    child:const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: ColorManger.kPanfsaji,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                  ),
                ),
              )


            ],

          ),
        ),
      ),
    );
  }
}
