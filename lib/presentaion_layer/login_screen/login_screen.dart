import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edu_events/controller/user_controller.dart';
import 'package:edu_events/presentaion_layer/main_screen/main_screen.dart';
import 'package:edu_events/presentaion_layer/resources/button_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../main_screen/home_screen.dart';
import '../resources/color_manger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  bool isObsecure=true;
  final _userController=Get.find<UserController>(tag: 'user_controller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:const EdgeInsetsDirectional.all(20),
            child: Column(
              children: [
                Image.asset('assets/images/logo.png',height: 400,),
                const  Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ColorManger.kPanfsaji
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration:const InputDecoration(
                    // border: InputBorder.none,
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                  obscureText: isObsecure,

                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: GestureDetector(
                      onTap: (){
                        isObsecure=!isObsecure;
                        setState(() {

                        });
                      },
                        child: Icon(isObsecure? Icons.visibility_off_outlined:Icons.visibility_outlined))
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),

             Obx(()=>
                 ConditionalBuilder(
                 condition:_userController.isLoading ,
                 builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kPanfsaji,)),
                 fallback: (context)=> myButton(title: 'Login', onTap: ()async{
                 await  _userController.login(email: _emailController.text, password: _passwordController.text);

                 })))



              ],

            ),
          ),
        ),
      ),
    );
  }
}
