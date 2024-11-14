import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edu_events/controller/main_controller.dart';
import 'package:edu_events/presentaion_layer/resources/button_manger.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:edu_events/shared/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _titleController=TextEditingController();
  final _dateController=TextEditingController();
  final _locationController=TextEditingController();
  final _timeController=TextEditingController();
  final _descriptionController=TextEditingController();
  final _mainController=Get.find<MainController>(tag: 'main_controller');

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
            controller: _titleController,
            decoration:const InputDecoration(
              // border: InputBorder.none,
              labelText: 'Event Title',
              prefixIcon: Icon(Icons.title),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: 'Event Date',
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
                _dateController.text = formattedDate;
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Event Description',
              prefixIcon: Icon(Icons.description),
            ),

          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: _timeController,
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());

              showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now()).then((value){
                 if(value!=null){
                   _timeController.text=value.format(context).toString();
                   setState(() {

                   });
                 }
              });
            },
            decoration:const InputDecoration(
              // border: InputBorder.none,
              labelText: 'Event Time',
              prefixIcon: Icon(Icons.watch_later),
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
             if(_mainController.eventImage!=null&&_timeController.text.isNotEmpty&&_dateController.text.isNotEmpty&&_titleController.text.isNotEmpty&&_descriptionController.text.isNotEmpty){
               await  _mainController.addEvent(eventName: _titleController.text, eventTime: _timeController.text, eventDate: _dateController.text,eventImage: _mainController.eventImage!,description: _descriptionController.text).then((value){
                 _timeController.clear();
                 _dateController.clear();
                 _titleController.clear();
                 _descriptionController.clear();
                 _mainController.eventImage?.delete();
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
