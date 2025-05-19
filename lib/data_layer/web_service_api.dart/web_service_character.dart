import '../../helpers/constants/end_points.dart';
import 'package:dio/dio.dart';

class WebServiceCharacter {
  late Dio dio;
  WebServiceCharacter() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20), // 60 seconds,
      receiveTimeout: Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get(characters);
      print(response.data["results"]);
      return response.data["results"];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
