import 'package:edu_events/controller/main_controller.dart';
import 'package:edu_events/model/event_model.dart';
import 'package:edu_events/model/work_shop_model.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
   bool isEvent=true;
   final _mainController=Get.find<MainController>(tag: 'main_controller');
   @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await _mainController.getHistoryEvents();

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>LoadingOverlay(isLoading: _mainController.isLoading,

      child:
      Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManger.kPanfsaji,
          title:const Text(
            'History Screen',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
          ),
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        ),
        body: SingleChildScrollView(
          padding:const EdgeInsetsDirectional.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(

                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if(isEvent){

                          }else{
                            isEvent=!isEvent;
                          }

                        });

                      },
                      child: Container(
                        height: 50,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: isEvent?ColorManger.kPanfsaji:Colors.white,
                            border: Border.all(
                                color: ColorManger.kPanfsaji
                            )
                        ),
                        child: Text(
                          'Events',
                          style: TextStyle(
                              color: isEvent?Colors.white:ColorManger.kPanfsaji,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if(isEvent){
                            isEvent=!isEvent;
                          }
                          else{

                          }
                        });
                      },
                      child: Container(
                        height: 50,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: isEvent?Colors.white:ColorManger.kPanfsaji,
                            border: Border.all(
                                color: ColorManger.kPanfsaji
                            )
                        ),
                        child: Text(
                          'Work Shops',
                          style: TextStyle(
                              color: isEvent?ColorManger.kPanfsaji:Colors.white,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if(isEvent)
                ListView.separated(
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      if(_mainController.isLoading==false&&_mainController.eventHistoryList.isEmpty){
                        return  const Center(
                          child: Text(
                            'There is No Events',
                            style: TextStyle(
                                color: ColorManger.kPanfsaji,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        );
                      }
                      else{
                        return buildEventItem(_mainController.eventHistoryList[index]);
                      }
                    },
                    separatorBuilder: (context,index)=>const SizedBox(
                      height: 15,
                    ),
                    itemCount: _mainController.eventHistoryList.length),
              if(!isEvent)
                ListView.separated(
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      if(_mainController.isLoading==false&&_mainController.workShopHistoryList.isEmpty){
                        return const Center(
                          child: Text(
                            'You Dont have Work Shops',
                            style: TextStyle(
                                color: ColorManger.kPanfsaji,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        );
                      }
                      else {
                        return buildWorkShopItem(_mainController.workShopHistoryList[index]);
                      }
                    },
                    separatorBuilder: (context,index)=>const SizedBox(
                      height: 15,
                    ),
                    itemCount:_mainController.workShopHistoryList.length),

            ],
          ),
        ),
      ),));
  }
  Widget buildEventItem(HistoryModelEvent model){
    return    Container(
      decoration: BoxDecoration(
          borderRadius:BorderRadiusDirectional.circular(20),
          color: Colors.white,
          border: Border.all(
              color: ColorManger.kPanfsaji
          )
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,

      child: Row(
        children: [
          Image.network('${model.image}',height: 150,width: 150,fit: BoxFit.cover,),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Title: ${model.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style:const TextStyle(
                      color: ColorManger.kPanfsaji,
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Event Id : ${model.id}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
   Widget buildWorkShopItem(HistoryWorkShopModel model){
     return    Container(
       decoration: BoxDecoration(
           borderRadius:BorderRadiusDirectional.circular(20),
           color: Colors.white,
           border: Border.all(
               color: ColorManger.kPanfsaji
           )
       ),
       clipBehavior: Clip.antiAliasWithSaveLayer,

       child: Row(
         children: [
           Image.network('${model.image}',height: 150,width: 150,fit: BoxFit.cover,),
           const SizedBox(
             width: 10,
           ),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   'WorkShop Title:${model.name}',
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,

                   style:const TextStyle(
                       color: ColorManger.kPanfsaji,
                       fontSize: 18,
                       fontWeight: FontWeight.w600
                   ),
                 ),
                 const SizedBox(
                   height: 10,
                 ),
                 Text(
                   'Work Shop Id :${model.id}',
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                   style:const TextStyle(
                       color: Colors.grey,
                       fontSize: 18,
                       fontWeight: FontWeight.w600
                   ),
                 )
               ],
             ),
           )

         ],
       ),
     );
   }

}
