import 'package:flutter/material.dart';
import 'Models/Message.dart';
import 'SignalRHelper.dart';

class ChatScreen extends StatefulWidget {
  final name;

  const ChatScreen({Key key, this.name}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var scrollController = ScrollController();
  var txtController = TextEditingController();
  SignalRHelper signalR = new SignalRHelper();

  receiveMessageHandler(args) {
    signalR.messageList.add(Message(
        name: args[0], message: args[1], isMine: args[0] == widget.name));
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 75);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              itemCount: signalR.messageList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(
                    signalR.messageList[i].isMine
                        ? signalR.messageList[i].message
                        : signalR.messageList[i].name +
                            ': ' +
                            signalR.messageList[i].message,
                    textAlign: signalR.messageList[i].isMine
                        ? TextAlign.end
                        : TextAlign.start,
                  ),
                );
              },
              separatorBuilder: (_, i) {
                return Divider(
                  thickness: 2,
                );
              },
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: txtController,
                decoration: InputDecoration(
                  hintText: 'Send Message',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () {
                      signalR..sendMessage(widget.name, txtController.text);
                      txtController.clear();
                      scrollController.jumpTo(
                          scrollController.position.maxScrollExtent + 75);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    signalR.connect(receiveMessageHandler);
  }

  @override
  void dispose() {
    txtController.dispose();
    scrollController.dispose();
    signalR.disconnect();
    super.dispose();
  }
}
