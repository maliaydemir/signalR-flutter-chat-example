import 'package:flutter/material.dart';
import 'package:signalr_test/chat_screen.dart';

class LoginScreen extends StatelessWidget {
  final nameController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Name'),
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
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 24),
              ))
        ],
      ),
    );
  }
}
