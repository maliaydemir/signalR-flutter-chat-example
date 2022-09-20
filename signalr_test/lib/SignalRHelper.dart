import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:signalr_client/hub_connection.dart';
import 'package:signalr_client/hub_connection_builder.dart';

import 'Models/Message.dart';

class SignalRHelper {
  final url = 'http://192.168.2.192:5000/chatHub';
  HubConnection hubConnection;
  var messageList = <Message>[];
  String textMessage='';

  void connect(receiveMessageHandler) {
    hubConnection = HubConnectionBuilder().withUrl(url).build();
    hubConnection.onclose((error) {
      log('Connection Close');
    });
    hubConnection.on('ReceiveMessage', receiveMessageHandler);
    hubConnection.start();
  }

  void sendMessage(String name, String message) {
    hubConnection.invoke('SendMessage', args: [name, message]);
    // messageList.add(Message(
    //     name: name,
    //     message: message,
    //     isMine: true));
    textMessage='';
  }

  void disconnect() {
    hubConnection.stop();
  }


}
