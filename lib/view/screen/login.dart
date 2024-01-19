import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: const Center(
        child:Column(children: [
          Text("Welcome back!",style: TextStyle(fontSize: 24)),
          
        ],)
      ),
    );
  }
}