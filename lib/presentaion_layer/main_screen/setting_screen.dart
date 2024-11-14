import 'package:edu_events/presentaion_layer/login_screen/login_screen.dart';
import 'package:edu_events/presentaion_layer/onboard_screen/on_board_screen.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../contact_us_screen/contact_us.dart';
import '../history_screen/history_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child:Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder:(context,index)=>buildSettingItem(index) ,
                separatorBuilder: (context,index)=> Divider(
                  height: 2,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                itemCount: 5),
          )
        ],
      ),
    );
  }
  Widget buildSettingItem(int index){

    List<Map<String,dynamic>> design=[

      {
        'title':'About App','Icon':Icons.info,

      },
      {
        'title':'Help','Icon':Icons.help,

      },
      {
        'title':'Contact Us','Icon':Icons.contact_page,

      },
      {
        'title':'History','Icon':Icons.history,

      },
      {
        'title':'Log Out','Icon':Icons.logout,

      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        behavior:
        HitTestBehavior.translucent,
        onTap: (){
          switch(index){
            case 0:
              break;
            case 1:
              break;
            case 2:
              Get.to(()=>const ContactUs());
              break;
            case 3:
              Get.to(()=>const HistoryScreen());
              break;
            case 4:
              Get.offAll(()=>const LoginScreen());
          }
        },
        child: Row(
          children: [

            Icon(
              design[index]['Icon'],
              color: ColorManger.kPanfsaji,
              size: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${design[index]['title']}',
              style:const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
              ),

            ),
            const Spacer(),
          const  Icon(Icons.arrow_forward_ios,color: ColorManger.kPanfsaji,size: 30,),






          ],
        ),
      ),
    );

  }

}
