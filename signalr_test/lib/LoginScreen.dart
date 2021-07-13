import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signalr_test/ChatScreen.dart';

class LoginScreen extends StatelessWidget {
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
          ),
          TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ChatScreen(name: nameController.text)));
                }
              },
              child: Text('Login',style: TextStyle(fontSize: 24),))
        ],
      ),
    );
  }
}
