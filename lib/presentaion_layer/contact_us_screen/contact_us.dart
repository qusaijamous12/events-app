import 'package:edu_events/controller/main_controller.dart';
import 'package:edu_events/presentaion_layer/resources/button_manger.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:edu_events/shared/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';

class ContactUs extends StatefulWidget {
  static const String screenRoute = 'contact_us';

  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
   final _userController=Get.find<UserController>(tag: 'user_controller');
   final _mainController=Get.find<MainController>(tag: 'main_controller');

  final messageController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Contact Us',style: TextStyle(color: Colors.white),),backgroundColor: ColorManger.kPanfsaji,leading: IconButton(onPressed: (){
        Get.back();
      }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const  SizedBox(height: 8),
            Text(
              'Get in touch with a member of our coaching staff.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const   SizedBox(height: 16),
            Container(
              height: 150,
              padding:const EdgeInsetsDirectional.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorManger.kPanfsaji.withOpacity(0.3),
                  borderRadius: BorderRadiusDirectional.circular(20)
              ),
              child: TextFormField(
                style:const TextStyle(
                    color: Colors.white
                ),
                controller: messageController,
                decoration:const InputDecoration(
                    prefixIcon: Icon(Icons.email,color: Colors.white,),
                    hintText: 'Wtite you message here ...',
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    border: InputBorder.none

                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                width: double.infinity,
                child: myButton(title: 'Send', onTap: ()async{
                  if(messageController.text.isNotEmpty){
                  await  _mainController.contactUsMessage(message: messageController.text, userName: _userController.userModel.name!, uid: _userController.userModel.uid!, userEmail: _userController.userModel.email!);
                  messageController.clear();
                  }
                  else{
                    Utils.myToast(title: 'Message is requierd');
                  }

                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}