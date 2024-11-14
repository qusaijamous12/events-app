class EventModel{
 final  String eventDate;
 final String eventImage;
 final String eventTime;
 final String eventTitle;
 final String uid;
 final String descriptionModel;

 EventModel({
   required this.eventImage,
   required this.eventDate,
   required this.eventTime,
   required this.uid,
   required this.descriptionModel,
   required this.eventTitle
});

 factory EventModel.fromJson(Map<String,dynamic> json){
   return EventModel(
       eventImage: json['event_image'],
       eventDate: json['event_date'],
       eventTime: json['event_time'],
       uid: json['uid'],
       descriptionModel: json['description'],
       eventTitle: json['event_title']);
 }

}

class HistoryModelEvent {
  final String id;
  final String image;
  final String name;


  HistoryModelEvent({
    required this.id,
    required this.image,
    required this.name,

  });

  factory HistoryModelEvent.fromJson(Map<String, dynamic> json){
    return HistoryModelEvent(
        id: json['event_id'],
        image: json['event_image'],
        name: json['event_name']);
  }
}

class HistoryWorkShopModel {
  final String id;
  final String image;
  final String name;


  HistoryWorkShopModel({
    required this.id,
    required this.image,
    required this.name,

  });

  factory HistoryWorkShopModel.fromJson(Map<String, dynamic> json){
    return HistoryWorkShopModel(
        id: json['work_shop_id'],
        image: json['work_shop_image'],
        name: json['work_shop_name']);
  }
}
