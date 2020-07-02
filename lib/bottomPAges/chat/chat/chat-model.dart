class ChatModel {
  final DateTime date;
  final String message;
  final bool me;
  ChatModel({this.me,this.date,this.message});
}

List<ChatModel> chatMessages = [
  ChatModel(
      date: DateTime.now(),
      message: "Hello?",
      me: true
  ),
  ChatModel(
      date: DateTime.now(),
      message: "How are you?",
      me: false
  ),
  ChatModel(
      date: DateTime.now(),
      message: "How are you?",
      me: true
  ),
  ChatModel(
    date: DateTime.now(),
    message: "How are you?",
    me: false,
  ),
  ChatModel(
    date: DateTime.now(),
    message: "I am fine",
    me: false,
  ),
  ChatModel(
      date: DateTime.now(),
      message: "What's up?",
      me: true
  ),
  ChatModel(
      date: DateTime.now(),
      message: "How are you doing?",
      me: true
  ),

];