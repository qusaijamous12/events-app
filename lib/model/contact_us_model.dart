class ContactUsModel{
  final String userName;
  final String userEmail;
  final String userId;
  final String userMessage;
  ContactUsModel({
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userMessage
});
  factory ContactUsModel.fromJson(Map<String,dynamic> json){
    return ContactUsModel(
    userId: json['uid'],
    userEmail: json['email'],
  userName: json['name'],
  userMessage: json['message']);
  }
}