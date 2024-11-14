import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edu_events/controller/main_controller.dart';
import 'package:edu_events/model/contact_us_model.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsMessages extends StatefulWidget {
  const ContactUsMessages({super.key});

  @override
  State<ContactUsMessages> createState() => _ContactUsMessagesState();
}

class _ContactUsMessagesState extends State<ContactUsMessages> {
  final _mainController=Get.find<MainController>(tag: 'main_controller');
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
     await _mainController.getContactUsMessages();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>ConditionalBuilder(
        condition: _mainController.isLoading,
        builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kPanfsaji,)),
        fallback: (context){
          if(_mainController.contactUsList.isEmpty&&_mainController.isLoading==false){
            return const Center(
              child: Text(
                'There is No Messages !',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: ColorManger.kPanfsaji
                ),
              ),
            );
          }
          else{
            return ListView.separated(
                padding:const EdgeInsetsDirectional.all(20),
                itemBuilder: (context,index)=>buildContactUsItem(_mainController.contactUsList[index]),
                separatorBuilder: (context,index)=>const SizedBox(
                  height: 10,
                ),
                itemCount: _mainController.contactUsList.length);
          }
        }));
  }
  Widget buildContactUsItem(ContactUsModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
       const   CircleAvatar(
            backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYP-KKtRJXm9qK7k2_PA1utxbxWdpzGIdulQ&s'),
            radius: 50,

          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${model.userName}',
            style:const TextStyle(
                color: ColorManger.kPanfsaji,
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
          ),

        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        'Message : ${model.userMessage}',
        style:const TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),
      )
    ],
  );
}
