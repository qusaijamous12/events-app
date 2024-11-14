class MessageModel{
  final String userId;
  final String message;
  MessageModel({
    required this.message,
    required this.userId
});
  factory MessageModel.fromJson(Map<String,dynamic> json){
    return MessageModel(
        message: json['message'],
        userId: json['user_id']);
  }
}