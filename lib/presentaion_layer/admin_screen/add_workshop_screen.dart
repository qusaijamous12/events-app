import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/main_controller.dart';
import '../../shared/utils.dart';
import '../resources/button_manger.dart';
import '../resources/color_manger.dart';

class AddWorkShopScreen extends StatefulWidget {
  const AddWorkShopScreen({super.key});

  @override
  State<AddWorkShopScreen> createState() => _AddWorkShopScreenState();
}

class _AddWorkShopScreenState extends State<AddWorkShopScreen> {
  final _workShopTitleController=TextEditingController();
  final _workShopDateController=TextEditingController();
  final _locationController=TextEditingController();
  final _workShopTimeController=TextEditingController();
  final _mainController=Get.find<MainController>(tag: 'main_controller');
  final _numberOfAttendees=TextEditingController();
  final _descriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:const EdgeInsetsDirectional.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Please Fill the Following Fields to add a Event ...',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 20
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Chose an Image for the event ',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 20
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(()=>GestureDetector(
            onTap: ()async{
              await   _mainController.choseImage();
            },
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  color: ColorManger.kPrimary.withOpacity(0.3)
              ),
              child:_mainController.eventImage==null?const Icon(Icons.camera_alt_outlined,size: 150,color: Colors.white,):Image(image: FileImage(_mainController.eventImage!)),

            ),
          )),
          const SizedBox(
            height: 15,
          ),

          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _workShopTitleController,
            decoration:const InputDecoration(
              // border: InputBorder.none,
              labelText: 'WorkShop Title',
              prefixIcon: Icon(Icons.title),
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          TextFormField(
            keyboardType: TextInputType.text,
            controller: _descriptionController,
            decoration:const InputDecoration(
              // border: InputBorder.none,
              labelText: 'Description',
              prefixIcon: Icon(Icons.description),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: _workShopDateController,
            decoration: const InputDecoration(
              labelText: 'WorkShop Date',
              prefixIcon: Icon(Icons.calendar_month),
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime now = DateTime.now();
              DateTime nextYear = DateTime(now.year + 1, now.month, now.day);

              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: now,
                lastDate: nextYear,
              );

              if (selectedDate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                _workShopDateController.text = formattedDate;
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: _workShopTimeController,
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());

              showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now()).then((value){
                if(value!=null){
                  _workShopTimeController.text=value.format(context).toString();
                  setState(() {

                  });
                }
              });
            },
            decoration:const InputDecoration(
              // border: InputBorder.none,
              labelText: 'WorkShop Time',
              prefixIcon: Icon(Icons.watch_later),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _numberOfAttendees,
            keyboardType: TextInputType.number,

            decoration:const InputDecoration(
              // border: InputBorder.none,
              labelText: 'Number of Attendees',
              prefixIcon: Icon(Icons.numbers),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // const Text(
          //   'Please Enter The Event Location ',
          //   style:TextStyle(
          //       color: Colors.grey,
          //       fontSize: 20
          //   ) ,
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          // Container(
          //   height: 200,
          //   width: double.infinity,
          //   color: ColorManger.kPrimary,
          // )
          const SizedBox(
            height: 10,
          ),
          Obx(()=>  ConditionalBuilder(
              condition: _mainController.isLoading,
              builder: (context)=>const Center(child: CircularProgressIndicator(color: ColorManger.kPanfsaji,)),
              fallback: (context)=> myButton(title: 'Add', onTap: ()async{
                if(_mainController.eventImage!=null&&_workShopTimeController.text.isNotEmpty&&_workShopDateController.text.isNotEmpty&&_workShopTitleController.text.isNotEmpty&&_numberOfAttendees.text.isNotEmpty&&_descriptionController.text.isNotEmpty){
                await _mainController.addWorkShops(workShopName: _workShopTitleController.text, workShopTime: _workShopTimeController.text, workShopDate: _workShopDateController.text, workShopImage: '', workShopAttendees: int.parse(_numberOfAttendees.text),description: _descriptionController.text).then((value){
                  _numberOfAttendees.clear();
                  _workShopDateController.clear();
                  _workShopTimeController.clear();
                  _workShopTitleController.clear();
                });
                }else{
                  Utils.myToast(title: 'All Fields are requierd');
                }

              })))



        ],
      ),
    );
  }
}
