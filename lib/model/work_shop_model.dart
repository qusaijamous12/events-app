class WorkShopModel{
  final  String workShopDate;
  final String workShopImage;
  final String workShopTime;
  final String workShopTitle;
  final String uid;
  final int numberOfAttendence;
  final String description;

  WorkShopModel({
    required this.workShopImage,
    required this.workShopDate,
    required this.workShopTime,
    required this.uid,
    required this.description,
    required this.workShopTitle,
    required this.numberOfAttendence
  });

  factory WorkShopModel.fromJson(Map<String,dynamic> json){
    return WorkShopModel(
        workShopImage: json['work_shop_image'],
        workShopDate: json['work_shop_date'],
        workShopTime: json['work_shop_time'],
        uid: json['uid'],
        description: json['description'],
        numberOfAttendence: json['work_shop_attendees'],
        workShopTitle: json['work_shop_name']);
  }

}