import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edu_events/model/work_shop_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/main_controller.dart';
import '../../shared/utils.dart';
import '../resources/button_manger.dart';
import '../resources/color_manger.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key,required this.model});
  final WorkShopModel model;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController=TextEditingController();
  final _dateController=TextEditingController();
  final _locationController=TextEditingController();
  final _timeController=TextEditingController();
  final _descriptionController=TextEditingController();
  final _numberOfAttendence=TextEditingController();
  final _mainController=Get.find<MainController>(tag: 'main_controller');

  @override
  void initState() {
    _titleController.text=widget.model.workShopTitle;
    _dateController.text=widget.model.workShopDate;
    _timeController.text=widget.model.workShopTime;
    _descriptionController.text=widget.model.description;
    _numberOfAttendence.text=widget.model.numberOfAttendence.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManger.kPanfsaji,
        leading: IconButton(onPressed: ()async{
          await _mainController.getEventList();
          Get.back();}, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title:const Text('Edit Screen',style: TextStyle(color: Colors.white,fontSize: 20,),),
      ),
      body:  Center(
        child: SingleChildScrollView(
          padding:const EdgeInsetsDirectional.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

             Align(
               alignment: AlignmentDirectional.center,
               child: CircleAvatar(
                 radius: 70,
                 backgroundImage: NetworkImage('${widget.model.workShopImage}'),
               ),
             ),
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
              TextFormField(
                controller: _numberOfAttendence,
                decoration:const InputDecoration(
                  // border: InputBorder.none,
                  labelText: 'Number of Attendence',
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),

       
              const SizedBox(
                height: 25,
              ),
              myButton(title: 'Update', onTap: ()async{
                FirebaseFirestore.instance.collection('work_shops').doc(widget.model.uid).update({
                  'description':_descriptionController.text,
                  'work_shop_attendees':int.parse(_numberOfAttendence.text),
                  'work_shop_date':_dateController.text,
                  'work_shop_name':_titleController.text,
                  'work_shop_time':_timeController.text
                }).then((value){
                  Utils.myToast(title: 'Update Success');
                });


              })



            ],
          ),
        ),
      ),
    );
  }
}
