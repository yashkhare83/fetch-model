import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

import 'model/usermodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // initalize list in which model add will be added
  List<UserModel> usersList = [];

  Future<List<UserModel>> getUserData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        usersList.add(UserModel.fromJson(i));
        print(usersList);
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: getUserData(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: usersList.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text("Title : ${snapshot.data![index].name}"),
                          subtitle: Text(
                              'Latitude: ${snapshot.data![index].address!.geo!.lat}'),
                        );
                      }));
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}
