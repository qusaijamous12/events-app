import 'package:edu_events/controller/main_controller.dart';
import 'package:edu_events/controller/user_controller.dart';
import 'package:edu_events/model/messages_model.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../shared/utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key,required this.workShopId});
  final String workShopId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   final _mainController=Get.find<MainController>(tag: 'main_controller');
   final _userController=Get.find<UserController>(tag: 'user_controller');
  @override


  final _messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(

      builder: (BuildContext context) {
       _mainController.getWorkShopMessages(workShopId: widget.workShopId);


        return Obx(()=>LoadingOverlay(
            isLoading: _mainController.isLoading,
            child: Scaffold(
          appBar: AppBar(
            title:const Text('Message Screen',style: TextStyle(color: Colors.white),),backgroundColor: ColorManger.kPanfsaji,leading: IconButton(onPressed: (){
            Get.back();
          }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding:const EdgeInsetsDirectional.all(20),
                    decoration: BoxDecoration(
                        color: ColorManger.kPanfsaji.withOpacity(0.2),
                        borderRadius: BorderRadiusDirectional.circular(20)
                    ),
                    child: ListView.separated(
                        shrinkWrap: true,


                        itemBuilder: (context,index){
                          if(_mainController.messages[index].userId==_userController.userModel.uid){
                            return buildMyMessage(_mainController.messages[index]);
                          }
                          else{
                            return buildMessage(_mainController.messages[index]);

                          }
                        },
                        separatorBuilder: (context,index)=>const SizedBox(
                          height: 20,
                        ),
                        itemCount: _mainController.messages.length),

                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding:const EdgeInsetsDirectional.only(
                      start: 7
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer ,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1

                      ),
                      borderRadius: BorderRadius.circular(15 )
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){

                        },
                        child:const CircleAvatar(
                          child: Icon(Icons.image, color: Colors.grey,),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _messageController,
                          decoration:const InputDecoration(
                              hintText: 'type your message here...',
                              border: InputBorder.none
                          ),
                        ),

                      ),
                      Container(
                        color: ColorManger.kPanfsaji,
                        height: 60,
                        width: 60,

                        child: IconButton(
                            onPressed: (){
                              if(_messageController.text.isNotEmpty){
                                _mainController.sendMessage(senderId: _userController.userModel.uid!, message: _messageController.text, workShopId: widget.workShopId);
                                _messageController.clear();

                              }else{
                                Utils.myToast(title: 'Message is Requierd');
                              }

                            },
                            icon:const Icon(
                              Icons.send,
                              color: Colors.white,

                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

        )));
      },
    );
  }
  Widget buildMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYP-KKtRJXm9qK7k2_PA1utxbxWdpzGIdulQ&s'),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding:const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius:const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),



              )
          ),
          child: Text(
            '${model.message}',
            style:const TextStyle(
                fontSize: 18
            ),
          ),
        ),
      ],
    ),
  );
  Widget buildMyMessage(MessageModel model)=>  Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Row(

      textDirection: TextDirection.rtl,
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYP-KKtRJXm9qK7k2_PA1utxbxWdpzGIdulQ&s'),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding:const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5
          ),
          decoration:const BoxDecoration(
              color: ColorManger.kPanfsaji,
              borderRadius:const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),



              )
          ),
          child: Text(
            '${model.message}',
            style:const TextStyle(
                color: Colors.white,
                fontSize: 18
            ),
          ),
        ),
      ],
    ),
  );
}
