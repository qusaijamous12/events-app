import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edu_events/controller/main_controller.dart';
import 'package:edu_events/controller/user_controller.dart';
import 'package:edu_events/presentaion_layer/login_screen/login_screen.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/button_manger.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userController=Get.find<UserController>(tag: 'user_controller');
  final _emailController=TextEditingController();
  final _uidController=TextEditingController();
  final _phoneController=TextEditingController();
  final _nameController=TextEditingController();
  final _mainController=Get.find<MainController>(tag: 'main_controller');
  bool isObsecure=true;

  @override
  void initState() {
    _emailController.text=_userController.userModel.email!;
    _phoneController.text=_userController.userModel.phone!;
    _nameController.text=_userController.userModel.name!;
    _uidController.text=_userController.userModel.uid!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding:const EdgeInsetsDirectional.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage:const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYP-KKtRJXm9qK7k2_PA1utxbxWdpzGIdulQ&s'),
              backgroundColor: Colors.red,
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: CircleAvatar(
                  backgroundColor: ColorManger.kPanfsaji,
                  child: IconButton(
                      onPressed: (){},
                      icon:const Icon(Icons.edit,color: Colors.white,)),
                ),
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
              enabled: false,
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
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              decoration:const InputDecoration(
                // border: InputBorder.none,
                labelText: 'Mobile Number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextFormField(
              enabled: false,
              keyboardType: TextInputType.phone,
              controller: _uidController,
              decoration:const InputDecoration(
                // border: InputBorder.none,
                labelText: 'User Id',
                prefixIcon: Icon(Icons.numbers),
              ),
            ),

            const SizedBox(
              height: 35,
            ),

            Row(
              children: [

                Obx(()=>ConditionalBuilder(
                    condition: _mainController.isLoading,
                    builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kPanfsaji,)),
                    fallback: (context)=>Expanded(
                      child: GestureDetector(
                        onTap: ()async{
                          await  _mainController.updateProfileData(name: _nameController.text,phoneNumber: _phoneController.text);

                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: ColorManger.kPanfsaji,

                          ),
                          child:const Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                        ),
                      ),
                    ))),

                const SizedBox(width: 10,),

                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.offAll(()=>const LoginScreen());
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
                        'Log Out',
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
            )


          ],
        ),
      ),
    );
  }
}
