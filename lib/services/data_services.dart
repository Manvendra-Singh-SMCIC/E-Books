// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:book_reader_app/model/data_model.dart';
import 'package:book_reader_app/model/intro_page_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DataServices {
  String baseUrl = "http://192.168.238.98/api/introPage";

  Future<List<HomePageDataModel>> getInfo() async {
    Dio dio = Dio();
    var res = await dio.get(baseUrl);
    try {
      if (res.statusCode == 200) {
        var responseData = res.data as List;
        print("HI");
        print(responseData);
        return responseData.map((e) => HomePageDataModel.fromJson(e)).toList();
      } else {
        return <HomePageDataModel>[];
      }
    } catch (e) {
      print(e);
      return <HomePageDataModel>[];
    }
  }
}
