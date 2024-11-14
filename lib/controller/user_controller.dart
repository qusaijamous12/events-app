import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_events/model/user_model.dart';
import 'package:edu_events/presentaion_layer/login_screen/login_screen.dart';
import 'package:edu_events/presentaion_layer/main_screen/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../shared/utils.dart';

class UserController extends GetxController{
  final _isLoading=RxBool(false);
  final _userModel=Rx<UserModel>(UserModel());


  Future<void> login({required String email,required String password})async{
    _isLoading(true);
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value)async{
          if(value!=null){
            if(value.user?.uid!=null){
              await getUserData(uid: value.user!.uid);
              Utils.myToast(title: 'Login Success');
              Get.offAll(()=>const MainScreen());



            }
          }

    }).catchError((error){
      print('there is an error when user Login');
      Utils.myToast(title: 'Login Failed');
    });
    _isLoading(false);
  }

  Future<void> getUserData({required String uid})async{
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value){
      if(value.data() != null){
        _userModel(UserModel.fromJson(value.data()!));

      }

    }).catchError((error){
      print('there is an error when get user data !!');
    });
  }

  Future<void> register({required String email,required String password,required String name,required String phone})async{
    _isLoading(true);
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)async{
      if(value.user?.uid!=null){
      await  FirebaseFirestore.instance.collection('users').doc(value.user?.uid).set({
          'email':email,
          'phone':phone,
          'status':0,
          'name':name,
          'uid':value.user?.uid,
          'profile_image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYP-KKtRJXm9qK7k2_PA1utxbxWdpzGIdulQ&s'
        }).then((value){
          Utils.myToast(title: 'Register Success');
          Get.offAll(()=>const LoginScreen());

      }).catchError((error){
        Utils.myToast(title: 'Register Failed');
      });

      }

    }).catchError((error){
      print('there is an error when register$error');
      Utils.myToast(title: 'Register Failed');
    });
    _isLoading(false);
  }



  bool get isLoading=>_isLoading.value;
  UserModel get userModel=>_userModel.value;

}