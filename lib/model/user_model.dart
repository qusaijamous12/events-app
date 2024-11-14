import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  final String ?name;
  final String ?phone;
  final String ?email;
  final String ?uid;
  final int ?status;
  final String ?profileImage;
  UserModel({
    this.name,
    this.uid,
    this.phone,
    this.email,
    this.status,
    this.profileImage
});
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      uid: json['uid'],
      profileImage: json['profile_image']??'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYP-KKtRJXm9qK7k2_PA1utxbxWdpzGIdulQ&s'
    );
  }



}