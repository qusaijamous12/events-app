import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edu_events/model/event_model.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:edu_events/shared/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/main_controller.dart';
import '../resources/button_manger.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({super.key,required this.model});
  final EventModel model;

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final _titleController=TextEditingController();
  final _dateController=TextEditingController();
  final _timeController=TextEditingController();
  final _descriptionController=TextEditingController();
  final _mainController=Get.find<MainController>(tag: 'main_controller');
  
  @override
  void initState() {
    _timeController.text=widget.model.eventTime;
    _titleController.text=widget.model.eventTitle;
    _descriptionController.text=widget.model.descriptionModel;
    _dateController.text=widget.model.eventDate;
    
    
    
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()async{
         await _mainController.getEventList();
          Get.back();
          }, icon:const Icon(Icons.arrow_back_ios,color:Colors.white,)),
        backgroundColor: ColorManger.kPanfsaji,
        title:const Text('Edit Event Screen',style: TextStyle(color: Colors.white,fontSize: 20),),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding:const EdgeInsetsDirectional.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Align(
                alignment: AlignmentDirectional.center,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage('${widget.model.eventImage}'),
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
            
              const SizedBox(
                height: 10,
              ),
              myButton(title: 'Update', onTap: ()async{
                FirebaseFirestore.instance.collection('events').doc(widget.model.uid).update({
                  'description':_descriptionController.text,
                  'event_date':_dateController.text,
                  'event_time':_timeController.text,
                  'event_title':_titleController.text,


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
