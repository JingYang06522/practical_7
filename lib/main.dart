import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage()

    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //controller
  final nameCtrl= TextEditingController();
  final emailCtrl = TextEditingController();

  void _loadProfile() async{
    final prefs = await SharedPreferences.getInstance();

    nameCtrl.text = prefs.getString('name') ?? "";
    emailCtrl.text = prefs.getString('email') ?? "";
  }

  void _updateProfile() async{
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('name', nameCtrl.text);
    prefs.setString('email', emailCtrl.text);
  }

  @override
  void iniState(){
    _loadProfile();
    super.initState();
  }

  @override
  void dispose(){
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: nameCtrl,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Name'
                ),
              ),
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email"
                ),
              ),
              Expanded(
                  child: SizedBox()
              ),
              ElevatedButton(
                  onPressed: _updateProfile,
                  child: Text('Update')
              )
            ],
          ),
        ),
      ),
    );
  }
}
