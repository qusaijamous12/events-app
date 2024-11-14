import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edu_events/controller/main_controller.dart';
import 'package:edu_events/model/event_model.dart';
import 'package:edu_events/model/work_shop_model.dart';
import 'package:edu_events/presentaion_layer/event_screen/event_screen.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:edu_events/presentaion_layer/work_shops_screen/work_shops_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _mainController=Get.find<MainController>(tag: 'main_controller');

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
    await  _mainController.getEventList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CarouselSlider(

                items: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:const Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcdeVsllO9hB2Lb4_XGRPhuT7OiJqIMuQ_lA&s'),fit: BoxFit.fill,)),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:const Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPVZtQyB3qTlxAY84Fnr0ADYk8YvYWhmA0bw&s'),fit: BoxFit.fill,)),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:const Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRel73WJyZ0GKqE6GjQOmYsoZtnVIjtKOtkkQ&s'),fit: BoxFit.fill,)),

                ],
                options: CarouselOptions(
                    height: 300,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval:const Duration(seconds: 3),
                    autoPlayAnimationDuration:const Duration(seconds: 1),
                    autoPlayCurve: Curves.easeInBack,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1 // we use it to solve the problem of images that occuer when we dont use it try to put insted of 1 0.4 and you will see the problem
                )),
          ),

          Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text(
                'Find the trending events',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(
                height: 30,
              ),
             const Text(
                'Popular Events',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(()=>ConditionalBuilder(
                condition: _mainController.isLoading,
                builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kPanfsaji,)),
                fallback: (context){
                  if(_mainController.isLoading==false&&_mainController.eventList.isEmpty){
                    return const Center(
                      child:  Text(
                        'There is No Events Now',
                        style: TextStyle(
                          color: ColorManger.kPanfsaji,
                          fontSize: 25,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    );
                  }else{
                   return Container(
                      height: 400,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index)=>buildEventItem(eventModel: _mainController.eventList[index]),
                          separatorBuilder: (context,index)=>const SizedBox(
                            width: 10,
                          ),
                          itemCount: _mainController.eventList.length),
                    );
                  }

                }),),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Popular WorkShops',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(()=>ConditionalBuilder(
                  condition:_mainController.isLoading ,
                  builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kPanfsaji,)),
                  fallback: (context){
                    if(_mainController.workShopList.isEmpty&&_mainController.isLoading==false){
                      return  const SizedBox(
                        height: 160,
                        child:  Center(
                          child:  Text('There is No Work Shops Now ',style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: ColorManger.kPanfsaji
                          ),),
                        ),
                      );
                    }else{
                      return  Container(
                        height: 420,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index)=>buildWorkShopItem(model: _mainController.workShopList[index]),
                            separatorBuilder: (context,index)=>const SizedBox(
                              width: 10,
                            ),
                            itemCount: _mainController.workShopList.length),
                      );
                    }
                  })),



            ],
          ),
        )

        ],
      ),
    );
  }

  Widget buildEventItem({required EventModel eventModel})=>Card(
    elevation: 10,
    color: Colors.white,
    child: Container(
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.center,

                child: Image.network('${eventModel.eventImage}')),
            const  SizedBox(
              height: 15,
            ),
              Text(
              '${eventModel.eventDate}',
              style:const TextStyle(
                color: Colors.grey,
                fontSize: 18
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             Text(
              '${eventModel.eventTitle}',style:const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,fontSize: 20
            ),
            ),
            const  Row(
              children: [
                Icon(Icons.location_on_outlined,color: Colors.grey,),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Amman - Jordan',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey
                  ),
                ),

              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GestureDetector(
                  onTap: (){
                    Get.to(()=> EventScreen(model: eventModel,));
                  },
                  child: Container(
                    height: 50,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      color: ColorManger.kPanfsaji
                    ),
                    child:const Text(
                      'Interested',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
  Widget buildWorkShopItem({required WorkShopModel model})=>Card(
    elevation: 10,
    color: Colors.white,
    child: Container(
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: AlignmentDirectional.center,

                child: Image.network('${model.workShopImage}')),
            const  SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${model.workShopDate}',
                  style:const TextStyle(
                      color: Colors.grey,
                      fontSize: 18
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const  Text(
                      'Available seats',
                      style:const TextStyle(
                          color: Colors.grey,
                          fontSize: 18
                      ),
                    ),
                      if(model.numberOfAttendence>0)
                      Text(
                      '${model.numberOfAttendence}',
                      style:const TextStyle(
                          color: ColorManger.kPanfsaji,
                          fontSize: 18
                      ),
                    ),
                    if(model.numberOfAttendence==0)
                      Container(
                        height: 40,
                        padding:const EdgeInsetsDirectional.symmetric(horizontal: 10),
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: ColorManger.kPanfsaji
                        ),
                        child:const Text(
                          'Not Available',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      )
                  ],
                ),

              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${model.workShopTitle}',style:const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,fontSize: 20
            ),
            ),
            const  Row(
              children: [
                Icon(Icons.location_on_outlined,color: Colors.grey,),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Amman - Jordan',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                  ),
                ),

              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GestureDetector(
                  onTap: (){
                    Get.to(()=>WorkShopsScreen(model: model));
                  },
                  child: Container(
                    height: 50,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(20),
                        color: ColorManger.kPanfsaji
                    ),
                    child:const Text(
                      'Interested',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
