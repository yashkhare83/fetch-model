import 'dart:convert';

import 'package:fetch_model_2/model/categoryModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // category list
  List<CategoryModel> categoryList = [];
  // get method
  Future<List<CategoryModel>> getCategoryList() async {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/categories'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        categoryList.add(CategoryModel.fromJson(i));
      }
      return categoryList;
    } else {
      return categoryList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCategoryList(),
        builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
          return ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Text('Title : ${snapshot.data![index].name}'),
                );
              });
        });
  }
}
