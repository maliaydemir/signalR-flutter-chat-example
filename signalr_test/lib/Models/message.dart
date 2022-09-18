class Message {
  String name;
  String message;
  bool isMine = false;

  Message({required this.name, required this.message, this.isMine = false});
}
