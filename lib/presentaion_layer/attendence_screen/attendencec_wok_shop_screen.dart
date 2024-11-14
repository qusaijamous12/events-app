import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';
import '../../controller/user_controller.dart';
import '../../model/user_model.dart';
import '../chat_screen/chat_screen.dart';
import '../resources/color_manger.dart';

class AttendenceWorkShopScreen extends StatefulWidget {
  const AttendenceWorkShopScreen({super.key,required this.workShopId});
  final String workShopId;


  @override
  State<AttendenceWorkShopScreen> createState() => _AttendenceWorkShopScreenState();
}

class _AttendenceWorkShopScreenState extends State<AttendenceWorkShopScreen> {
  final _mainController=Get.find<MainController>(tag: 'main_controller');
  final _userController=Get.find<UserController>(tag: 'user_controller');
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await _mainController.getAttendessWorkShopUsers(workShopId: widget.workShopId);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        backgroundColor: ColorManger.kPanfsaji,
        title:const Text(
          'Attendence Screen',
          style: TextStyle(

              color: Colors.white
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=> ChatScreen(workShopId: widget.workShopId,));
          },
              icon: const Icon(Icons.message,
              color: Colors.white,))
        ],
      ),
      body: SingleChildScrollView(
        padding:const EdgeInsetsDirectional.all(20),
        child: Column(
          children: [
            Obx(()=>ConditionalBuilder(
                condition: _mainController.isLoading,
                builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kPanfsaji,)),
                fallback: (context)=>ListView.separated(
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics(),
                    itemBuilder:(context,index)=>buildUserItem(_mainController.attendessWorkShopList[index]) ,
                    separatorBuilder: (context,index)=>const Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 1,
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: _mainController.attendessWorkShopList.length)))

          ],
        ),
      ),

    );
  }
  Widget buildUserItem(UserModel model)=>Row(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage('${model.profileImage}'),
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.uid==_userController.userModel.uid?'You':model.name}',
            style:const TextStyle(
                color:Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${model.email}',
            style:const TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w700
            ),
          )

        ],
      ),

    ],
  );
}
