import 'package:book_reader_app/api_url/ApiUrl.dart';
import 'package:book_reader_app/model/intro_page_model.dart';
import 'package:dio/dio.dart';

class IntroPageItems {
  List introPageItems = [];

  void getInfo() async {
    String baseUrl = "http://${ApiUrl.url}/api/introPage";
    Dio dio = Dio();
    var res = await dio.get(baseUrl);
    try {
      print(res.statusCode);
      print(res.data);
      var responseData = res.data as List;
      introPageItems =
          responseData.map((e) => HomePageDataModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
  }

  List getList() {
    getInfo();
    return introPageItems;
  }
}
