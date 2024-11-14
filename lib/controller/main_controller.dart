import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_events/controller/user_controller.dart';
import 'package:edu_events/model/contact_us_model.dart';
import 'package:edu_events/model/event_model.dart';
import 'package:edu_events/model/messages_model.dart';
import 'package:edu_events/model/user_model.dart';
import 'package:edu_events/model/work_shop_model.dart';
import 'package:edu_events/presentaion_layer/admin_screen/add_event_screen.dart';
import 'package:edu_events/presentaion_layer/admin_screen/add_workshop_screen.dart';
import 'package:edu_events/presentaion_layer/admin_screen/admin_home_screen.dart';
import 'package:edu_events/presentaion_layer/main_screen/home_screen.dart';
import 'package:edu_events/presentaion_layer/main_screen/profile_screen.dart';
import 'package:edu_events/shared/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../presentaion_layer/contact_us_messages/contact_us_messages.dart';
import '../presentaion_layer/main_screen/setting_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storge;

class MainController extends GetxController{

  final _titles=RxList<String>([
    'Event Screen',
    'Profile Screen',
    'Setting Screen'
  ]);
  final _screens=RxList<Widget>(const [
    HomeScreen(),
    ProfileScreen(),
    SettingScreen()
  ]);
  final _currentIndex=RxInt(0);
  final _adminCurrentIndex=RxInt(0);
  final _adminTitles=RxList<String>([
    'Home Screen',
    'Event Screen',
    'WorkShop Screen',
    'Setting Screen'
  ]);
  final _adminScreen=RxList<Widget>(const [
    AdminHomeScreen(),
    AddEventScreen(),
    AddWorkShopScreen(),
    ContactUsMessages(),
  ]);
  final _imagePicker=Rxn<ImagePicker>(ImagePicker());
  final _eventImage=Rxn<File>(null);
  final _isLoading=RxBool(false);
  final _eventsList=RxList<EventModel>([]);
  final _workShopList=RxList<WorkShopModel>([]);
  final _userController=Get.find<UserController>(tag: 'user_controller');
  final _attendessEventList=RxList<UserModel>([]);
  final _attendessWorkShopList=RxList<UserModel>([]);
  final _eventHistoryList=RxList<HistoryModelEvent>([]);
  final _workShopHistoryList=RxList<HistoryWorkShopModel>([]);
  final _messageList=RxList<MessageModel>([]);
  final _contactUsList=RxList<ContactUsModel>([]);






  void changeCurrentIndex(int index){
    _currentIndex(index);
  }
  void changeAdminCurrentIndex(index){
    _adminCurrentIndex(index);
  }




  Future<void> choseImage()async{
    final result=await _imagePicker.value?.pickImage(source: ImageSource.gallery);
    if(result!=null){
      _eventImage(File(result.path));
    }else{
      Utils.myToast(title: ' Please Select an Image ');
    }
  }

  Future<void> addEvent({required String eventName,required String eventTime,required String eventDate,required File eventImage,required String description})async{
    _isLoading(true);

   final result=  await FirebaseFirestore.instance.collection('events').add({
      'event_title':eventName,
      'event_time':eventTime,
      'event_date':eventDate,
     'description':description,
      'event_image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyvetnLOz5AF4JPJGxqw0EJpwpBHl9swwqww&s'
    });
    await FirebaseFirestore.instance.collection('events').doc(result.id).update({
      'uid': result.id,
    }).then((value){
      Utils.myToast(title: 'Add Successfully');
    }).catchError((error){
      print('there is an error when add Event $error');
    });

    _isLoading(false);
  }
  Future<void> addWorkShops({required String workShopName,required String workShopTime,required String workShopDate,required String workShopImage,required int workShopAttendees,required String description})async{
    _isLoading(true);
   final result= await FirebaseFirestore.instance.collection('work_shops').add({
      'work_shop_name':workShopName,
      'work_shop_time':workShopTime,
      'work_shop_date':workShopDate,
     'description':description,
      'work_shop_attendees':workShopAttendees,
      'work_shop_image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvwRdZIoN5lTxZQnMvKo-dRDly4_vhlMpBaA&s'

    });
   await FirebaseFirestore.instance.collection('work_shops').doc(result.id).update({
     'uid': result.id,
   }).then((value){
     Utils.myToast(title: 'Add Successfully');
   }).catchError((error){
     print('there is an error when add work shop$error');
   });
   _isLoading(false);
  }





  Future<void> getEventList()async{
    _eventsList.clear();
    _isLoading(true);
    await FirebaseFirestore.instance.collection('events').get().then((value)async{
      value.docs.forEach((element){
        _eventsList.add(EventModel.fromJson(element.data()));
      });
      print('_eventsList.length${_eventsList.length}');
      await getWorkShopList();


    }).catchError((error){
      print('there is an error when get events');
    });
  }



  Future<void> getWorkShopList()async{
    _workShopList.clear();

    await FirebaseFirestore.instance.collection('work_shops').get().then((value){
      value.docs.forEach((element){
        print('elemnt is${element.data()}');
        _workShopList.add(WorkShopModel.fromJson(element.data()));
      });
      print('_workShopList.length${_eventsList.length}');

    }).catchError((error){
      print('there is an error when get _workShopList $error');
    });
    _isLoading(false);
  }


  Future<void> subscribeToEvent({required String eventImage, required String eventName, required String eventId}) async {
    _isLoading(true);

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_userController.userModel.uid)
        .collection('my_events')
        .where('event_id', isEqualTo: eventId)
        .get();


    if (snapshot.docs.isNotEmpty) {
      Utils.myToast(title: 'You are already subscribed');
      _isLoading(false);
      return;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(_userController.userModel.uid)
        .collection('my_events')
        .add({
      'event_image': eventImage,
      'event_name': eventName,
      'event_id': eventId,
    })
        .then((value) async{
      Utils.myToast(title: 'Subscription successful');
      await FirebaseFirestore.instance.collection('events').doc(eventId).collection('attendenss').doc(_userController.userModel.uid).set({
        'email':_userController.userModel.email,
        'name':_userController.userModel.name,
        'phone':_userController.userModel.phone,
        'profile_image':_userController.userModel.profileImage,
        'uid':_userController.userModel.uid
      });
    })
        .catchError((error) {
      print('There was an error subscribing: $error');
    });

    _isLoading(false);
  }


  Future<bool> isUserSubscribedToEvent(String eventId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_userController.userModel.uid)
        .collection('my_events')
        .where('event_id', isEqualTo: eventId)
        .get();

    return snapshot.docs.isNotEmpty; // Return true if the user is subscribed, false otherwise
  }


  Future<void> getAttendessEventUsers({required String eventId})async{
    _isLoading(true);
    _attendessEventList.clear();
    await FirebaseFirestore.instance.collection('events').doc(eventId).collection('attendenss').get().
    then((value){
      value.docs.forEach((element){
        _attendessEventList.add(UserModel.fromJson(element.data()));
      });


    }).catchError((error){
      print('there is an error when get attendence');
    });
    _isLoading(false);

  }


  Future<void> subscribeToWorkShop({required String workShopImage, required String workShopName, required String workShopId,}) async {
    _isLoading(true);

    // Check if the workshop has available spots
    final workshopDoc = await FirebaseFirestore.instance
        .collection('work_shops')
        .doc(workShopId)
        .get();

    if (workshopDoc.exists) {
      final int availableSpots = workshopDoc.data()?['work_shop_attendees'] ?? 0;

      if (availableSpots <= 0) {
        Utils.myToast(title: 'Not Available');
        _isLoading(false);
        return;
      }
    } else {
      Utils.myToast(title: 'Workshop not found');
      _isLoading(false);
      return;
    }

    // Check if the user is already subscribed to the workshop
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_userController.userModel.uid)
        .collection('work_shops')
        .where('work_shop_id', isEqualTo: workShopId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      Utils.myToast(title: 'You are already subscribed');
      _isLoading(false);
      return;
    }

    // Add user subscription
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_userController.userModel.uid)
        .collection('work_shops')
        .add({
      'work_shop_image': workShopImage,
      'work_shop_name': workShopName,
      'work_shop_id': workShopId,
    }).then((value) async {
      Utils.myToast(title: 'Subscription successful');

      // Add user to workshop's attendees collection
      await FirebaseFirestore.instance
          .collection('work_shops')
          .doc(workShopId)
          .collection('attendenss')
          .doc(_userController.userModel.uid)
          .set({
        'email': _userController.userModel.email,
        'name': _userController.userModel.name,
        'phone': _userController.userModel.phone,
        'profile_image': _userController.userModel.profileImage,
        'uid': _userController.userModel.uid,
      }).then((value) async {
        // Decrease the number of available spots in the workshop by 1
        await FirebaseFirestore.instance
            .collection('work_shops')
            .doc(workShopId)
            .update({
          'work_shop_attendees': FieldValue.increment(-1),
        });
      });
    }).catchError((error) {
      print('There was an error subscribing: $error');
    });

    _isLoading(false);
  }
  Future<bool> isUserSubscribedToWorkShop(String workShopId) async  {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_userController.userModel.uid)
        .collection('work_shops')
        .where('work_shop_id', isEqualTo: workShopId)
        .get();

    return snapshot.docs.isNotEmpty; // Return true if the user is subscribed, false otherwise
  }


  Future<void> getAttendessWorkShopUsers({required String workShopId})async{
    _isLoading(true);
    _attendessWorkShopList.clear();
    await FirebaseFirestore.instance.collection('work_shops').doc(workShopId).collection('attendenss').get().
    then((value){
      value.docs.forEach((element){
        _attendessWorkShopList.add(UserModel.fromJson(element.data()));
      });


    }).catchError((error){
      print('there is an error when get attendence');
    });
    _isLoading(false);

  }



  Future<void> updateProfileData({String ?name,String ?phoneNumber})async{
    _isLoading(true);
    await FirebaseFirestore.instance.collection('users').doc(_userController.userModel.uid).update({
      'name':name,
      'phone':phoneNumber
    }).then((value)async{
      Utils.myToast(title: 'Update Success');
    await  _userController.getUserData(uid: _userController.userModel.uid!);
    }).catchError((error){
      print('There is an error when update user Data $error');
    });
    _isLoading(false);
  }
  Future<void> contactUsMessage({required String message,required String userName,required String uid,required String userEmail})async{
    await FirebaseFirestore.instance.collection('contact_us').add({
      'name':userName,
      'email':userEmail,
      'uid':uid,
      'message':message
    }).then((value){
      Utils.myToast(title: 'Send Success');
    }).catchError((error){
      print('there is an error when send contact us message $message');
    });


  }
  Future<void> getHistoryEvents()async{
    _eventHistoryList.clear();
    _workShopHistoryList.clear();
    _isLoading(true);
    FirebaseFirestore.instance.collection('users').doc(_userController.userModel.uid).collection('my_events').get().then((value)async{
      value.docs.forEach((element){
        print('elemtn is ${element.data()}');

        _eventHistoryList.add(HistoryModelEvent.fromJson(element.data()));

      });
      await getHistoryWorkShops();


    }).catchError((error){
      print('there is an error when get history Events $error');
    });

    
    
  }
  Future<void> getHistoryWorkShops()async{

    FirebaseFirestore.instance.collection('users').doc(_userController.userModel.uid).collection('work_shops').get().then((value){
      value.docs.forEach((element){

        _workShopHistoryList.add(HistoryWorkShopModel.fromJson(element.data()));

      });

    }).catchError((error){
      print('there is an error when get history WorkShops');
    });
    _isLoading(false);


  }
  Future<void> getWorkShopMessages({required String workShopId})async{

  await FirebaseFirestore.instance.collection('work_shops').doc(workShopId).collection('messages').orderBy('dateTime',descending: false).snapshots().listen((event){
    _messageList.clear();
    event.docs.forEach((element){
      _messageList.add(MessageModel.fromJson(element.data()));
    });

  });
  }
  Future<void>sendMessage({required String senderId,required String message,required String workShopId})async{
    var dateTime = Timestamp.fromDate(DateTime.now());
    await FirebaseFirestore.instance.collection('work_shops').doc(workShopId).collection('messages').add({
      'message':message,
      'user_id':senderId,
      'dateTime':dateTime

    }).catchError((error){
      print('there is an error when send message');
    });
  }
  Future<void> getContactUsMessages()async{
    _contactUsList.clear();
    _isLoading(true);
    await FirebaseFirestore.instance.collection('contact_us').get().then((value){
      value.docs.forEach((element){
       _contactUsList.add(ContactUsModel.fromJson(element.data()));
      });

    }).catchError((error){
      print('there is an error when get contact us messages ! $error');
    });
    _isLoading(false);
  }





  List<MessageModel> get messages=>_messageList;
  List<WorkShopModel> get workShopList=>_workShopList;
  List<EventModel> get eventList=>_eventsList;
  ImagePicker ?get imagePicker=>_imagePicker.value;
  File ?get eventImage=>_eventImage.value;
  List<String> get titles=>_titles;
  List<Widget> get screens=>_screens;
  List<String> get adminTitles=>_adminTitles;
  List<Widget> get adminScreens=>_adminScreen;
  int get currentIndex=>_currentIndex.value;
  int get adminCurrentIndex=>_adminCurrentIndex.value;
  bool get isLoading=>_isLoading.value;
  List<UserModel> get attendessEventList=>_attendessEventList;
  List<UserModel> get attendessWorkShopList=>_attendessWorkShopList;
  List<HistoryModelEvent> get eventHistoryList=>_eventHistoryList;
  List<HistoryWorkShopModel> get workShopHistoryList=>_workShopHistoryList;
  List<ContactUsModel> get contactUsList=>_contactUsList;





}