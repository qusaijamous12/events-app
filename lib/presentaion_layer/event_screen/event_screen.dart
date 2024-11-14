import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edu_events/controller/main_controller.dart';
import 'package:edu_events/model/event_model.dart';
import 'package:edu_events/presentaion_layer/attendence_screen/attendence_screen.dart';
import 'package:edu_events/presentaion_layer/resources/button_manger.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/utils.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key,required this.model});
  final EventModel model;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final _mainController=Get.find<MainController>(tag: 'main_controller');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        backgroundColor: ColorManger.kPanfsaji,
        title:const Text(
          'Event Screen',
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
              child: Image.network('${widget.model.eventImage}',width: double.infinity,fit: BoxFit.cover,),
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
              '${widget.model.eventTitle}'.toUpperCase(),
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
                              '${widget.model.eventDate}',style:const TextStyle(
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
                              '${widget.model.eventTime}',style:const TextStyle(
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
              '${widget.model.descriptionModel}',
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
                            await  _mainController.subscribeToEvent(eventImage: widget.model.eventImage,eventId: widget.model.uid,eventName: widget.model.eventTitle);
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
                      onTap: () async {
    final isSubscribed = await _mainController.isUserSubscribedToEvent(widget.model.uid);

    if (isSubscribed) {
    Get.to(() => AttendenceScreen(eventId: widget.model.uid));
    } else {

    Utils.myToast(title: 'You must subscribe to the event first.');
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
