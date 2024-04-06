import 'dart:convert';

import 'package:fetch_model_2/model/newsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Future<NewsModel> getNewsData() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=bitcoin&apiKey=d1b7f2dbab5941278b59895ce363c8d8'));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return NewsModel.fromJson(data);
    } else {
      return NewsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: FutureBuilder(
              future: getNewsData(),
              builder: (context, AsyncSnapshot<NewsModel> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              "News Title : ${snapshot.data!.articles![index].title}"),
                        );
                      });
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
