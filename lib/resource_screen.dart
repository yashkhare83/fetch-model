import 'dart:convert';

import 'package:fetch_model_2/model/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

import 'model/resourceModel.dart';

class ResourceScreen extends StatefulWidget {
  const ResourceScreen({super.key});

  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  Future<ResourceModel> getResourceModel() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/unknown'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ResourceModel.fromJson(data);
    } else {
      return ResourceModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resource Screen'),
      ),
      body: FutureBuilder(
          future: getResourceModel(),
          builder: (context, AsyncSnapshot<ResourceModel> snapshot) {
            return Text(snapshot.data!.data![0].name.toString());
          }),
    );
  }
}
