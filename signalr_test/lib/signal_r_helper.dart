import 'dart:developer';

import 'package:signalr_core/signalr_core.dart';

import 'Models/message.dart';

class SignalRHelper {
  final url = 'https://84af-39-34-184-179.ap.ngrok.io/chatHub';
  HubConnection? hubConnection;
  var messageList = <Message>[];
  String textMessage = '';

  Future<void> connect(receiveMessageHandler) async {
    try {
      hubConnection = HubConnectionBuilder()
          .withAutomaticReconnect(1000)
          .withUrl(url)
          .build();
      hubConnection?.onclose((error) {
        log('Connection Close');
      });
      hubConnection?.on('ReceiveMessage', receiveMessageHandler);
      await _start();
    } catch (e) {
      log("SignalR " + e.toString());
    }
  }

  void sendMessage(String name, String message) {
    hubConnection?.invoke('SendMessage', args: [name, message]);
    // messageList.add(Message(
    //     name: name,
    //     message: message,
    //     isMine: true));
    textMessage = '';
  }

  Future<void> _start() async {
    await hubConnection?.start();
    log(hubConnection?.connectionId ?? "");
  }

  bool isWorking() {
    return hubConnection?.state?.index == 2;
  }

  Future<void> disconnect() async {
    hubConnection?.stop();
  }

  Future<void> reStart() async {
    await hubConnection?.stop();
    await _start();
    // await SignalRSend().identify();
  }

  Future<bool> restartIfNeedIt() async {
    if (!isWorking()) {
      await reStart();
    } else {
      // await SignalRSend().identify();
    }
    return isWorking();
  }
}
