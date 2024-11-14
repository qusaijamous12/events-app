import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edu_events/controller/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/utils.dart';
import '../resources/button_manger.dart';
import '../resources/color_manger.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _phoneController=TextEditingController();
  final _nameController=TextEditingController();
  final _userController=Get.find<UserController>(tag: 'user_controller');
  bool isObsecure=true;
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
                Image.asset('assets/images/logo.png',height: 350,),
                const  Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ColorManger.kPanfsaji
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  decoration:const InputDecoration(
                    // border: InputBorder.none,
                    labelText: 'User Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                  keyboardType: TextInputType.visiblePassword,
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
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration:const InputDecoration(
                    // border: InputBorder.none,
                    labelText: 'Mobile Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),

                Obx(()=>ConditionalBuilder(
                  condition: _userController.isLoading,
                  builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kPanfsaji,)),
                  fallback: (context)=>myButton(title: 'Register', onTap: ()async{
                    if(_emailController.text.isNotEmpty&&_passwordController.text.isNotEmpty&&_nameController.text.isNotEmpty&&_phoneController.text.isNotEmpty){
                      await _userController.register(email: _emailController.text, password: _passwordController.text, name: _nameController.text, phone: _phoneController.text);

                    }else{
                      Utils.myToast(title: 'All Fields Are requierd');
                    }
                  }),))




              ],

            ),
          ),
        ),

    ));
  }
}
