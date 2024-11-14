import 'package:edu_events/controller/main_controller.dart';
import 'package:edu_events/controller/user_controller.dart';
import 'package:edu_events/presentaion_layer/login_screen/login_screen.dart';
import 'package:edu_events/presentaion_layer/resources/color_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _mainController=Get.find<MainController>(tag: 'main_controller');
  final _userController=Get.find<UserController>(tag: 'user_controller');
  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(_userController.userModel.status==0){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: ColorManger.kPanfsaji,
            title: Text(
              '${_mainController.titles[_mainController.currentIndex]}',
              style:const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),


          body: _mainController.screens[_mainController.currentIndex],



          bottomNavigationBar:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(40),
                color: Colors.white,

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20
                ),
                child: GNav(
                  gap: 25,
                  backgroundColor:Colors.white,
                  tabBackgroundColor: ColorManger.kPanfsaji,
                  activeColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  selectedIndex: _mainController.currentIndex,
                  onTabChange: (index){
                    _mainController.changeCurrentIndex(index);

                  },

                  tabs:const [

                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                    ),
                    GButton(
                      icon: Icons.settings,
                      text: 'Setting',),


                  ],
                ),
              ),
            ),
          ),
        );
      }
      else{
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManger.kPanfsaji,
            title: Text(
              '${_mainController.adminTitles[_mainController.adminCurrentIndex]}',
              style:const TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ),
            actions: [
              IconButton(onPressed: (){
                Get.offAll(()=>const LoginScreen());
              }, icon:const Icon(Icons.logout,color:Colors.white,))
            ],
          ),
          body:  _mainController.adminScreens[_mainController.adminCurrentIndex],
          bottomNavigationBar:  BottomNavigationBar(
            // gap: 25,
           unselectedItemColor: Colors.black,
            selectedItemColor: ColorManger.kPanfsaji,
            currentIndex: _mainController.adminCurrentIndex,
            onTap: (index){
              _mainController.changeAdminCurrentIndex(index);

            },

            items:const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.event),label: 'Add Event'),
              BottomNavigationBarItem(icon: Icon(Icons.workspaces_outlined),label: 'Add WorkShops'),
              BottomNavigationBarItem(icon: Icon(Icons.message),label: 'Message'),


              // GButton(
              //   icon: Icons.event,
              //   text: 'Add Event',
              // ),
              // GButton(
              //   icon: Icons.workspaces_outlined,
              //   text: 'Add WorkShops',
              // ),
              // GButton(
              //   icon: Icons.message,
              //   text: 'Message',),


            ],
          ),

        );

      }
    });
  }
}
