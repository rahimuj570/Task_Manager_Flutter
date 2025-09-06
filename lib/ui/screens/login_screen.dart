import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text("Email"),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
