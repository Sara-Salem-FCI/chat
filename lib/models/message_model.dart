class Message{
  String message;
  String email;
  Message(this.message, this.email);
  factory Message.fromJson(jsonData){
    return Message(jsonData['message'],jsonData['email'] );
  }
}