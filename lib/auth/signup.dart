import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future register(email, password) async {
    var response = await http.post(Uri.parse('https://reqres.in/api/register'),
        body: {'email': email, 'password': password});

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Center(
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  var email = emailController.text.toString();
                  var password = passwordController.text.toString();
                  register(email, password);
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  height: 48,
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 7, 163, 2)),
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
