import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edu_events/controller/main_controller.dart';
import 'package:edu_events/model/work_shop_model.dart';
import 'package:edu_events/presentaion_layer/attendence_screen/attendencec_wok_shop_screen.dart';
import 'package:edu_events/shared/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/color_manger.dart';

class WorkShopsScreen extends StatefulWidget {
  const WorkShopsScreen({super.key,required this.model});
  final WorkShopModel model;


  @override
  State<WorkShopsScreen> createState() => _WorkShopsScreenState();
}

class _WorkShopsScreenState extends State<WorkShopsScreen> {
  final _mainController=Get.find<MainController>(tag: 'main_controller');
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
            'WorkShop Screen',
            style: TextStyle(

                color: Colors.white
            ),
          ),
        ),
        body:SingleChildScrollView(
          padding:const EdgeInsetsDirectional.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),

                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network('${widget.model.workShopImage}',width: double.infinity,fit: BoxFit.cover,),
              ),
              const SizedBox(
                height: 15,
              ),
              const  Text(
                'Event Title',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,

                ),
              ),
              Text(
                '${widget.model.workShopTitle}'.toUpperCase(),
                style:const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: ColorManger.kPanfsaji
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const  Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(

                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          padding:const EdgeInsetsDirectional.all(15),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(15),
                              color: ColorManger.kPanfsaji.withOpacity(0.3)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.model.workShopDate}',style:const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                              ),
                              const  Icon(Icons.calendar_month,color: Colors.white,size: 30,)

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          padding:const EdgeInsetsDirectional.all(15),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(15),
                              color: ColorManger.kPanfsaji.withOpacity(0.3)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.model.workShopTime}',style:const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                              ),
                              const  Icon(Icons.watch_later,color: Colors.white,size: 30,)

                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
              const  SizedBox(
                height: 20,
              ),
              const Text(
                'Additional Information',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
               Text(
                '${widget.model.description}',
                style:const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                      child: Obx(()=> ConditionalBuilder(
                        condition: _mainController.isLoading,
                        builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kPanfsaji,)),
                        fallback: (context)=>GestureDetector(
                          onTap: ()async{
                            await  _mainController.subscribeToWorkShop(workShopImage: widget.model.workShopImage, workShopName: widget.model.workShopTitle, workShopId: widget.model.uid);
                          },
                          child: Container(
                            height: 50,
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(20),
                                color: ColorManger.kPanfsaji
                            ),
                            child:const Text(
                              'Subscribe',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                              ),
                            ),

                          ),
                        ),
                      ),
                      )
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: ()async{
                        final isSubscibe=await _mainController.isUserSubscribedToWorkShop(widget.model.uid);
                        if(isSubscibe){
                          Get.to(()=>AttendenceWorkShopScreen(workShopId: widget.model.uid));
                        }
                        else{
                          Utils.myToast(title: 'You Have to Subscribe');
                        }



                      },
                      child: Container(
                        height: 50,

                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: Colors.white,
                            border: Border.all(
                                color: ColorManger.kPanfsaji
                            )
                        ),
                        child:const Text(
                          'Attendees',
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
        )
    );
  }
}
