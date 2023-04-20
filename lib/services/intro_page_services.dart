// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:book_reader_app/model/intro_page_model.dart';
import 'package:http/http.dart' as http;

class IntroPageDataServices {
  String baseUrl = "http://127.0.0.1:8000/api";

  Future<List<HomePageDataModel>> getInfo() async {
    var apiUrl = '/introPage';
    http.Response res = await http.get(Uri.parse(baseUrl+apiUrl));
    try {
      if(res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        print(list);
        return list.map((e) => HomePageDataModel.fromJson(e)).toList();
      } else {
        return <HomePageDataModel>[];
      }
    } catch (e) {
      print(e);
      return <HomePageDataModel>[];
    }
  }
}